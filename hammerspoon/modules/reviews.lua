-- Menu bar indicator for PRs awaiting my individual review.
--
-- Shows the count of open PRs matching "user-review-requested:@me" (only PRs
-- where I'm personally requested, not where one of my teams is). Clicking opens
-- a menu of "repo: title" entries (newest first); clicking an entry opens it.

local shared = require('modules.shared')
local Timers = shared.Timers
local log = shared.log

local GH = '/opt/homebrew/bin/gh'
-- Uses gh's default host (github.toasttab.com here). gh search prs has no
-- user-review-requested flag, so query the search API directly and let jq
-- shape the result into {repo, title, url} objects, newest first.
local GH_ARGS = {
  'api',
  '-X',
  'GET',
  'search/issues',
  '--raw-field',
  'q=is:pr user-review-requested:@me is:open',
  '--field',
  'sort=created',
  '--field',
  'order=desc',
  '--field',
  'per_page=100',
  '--jq',
  '[.items[] | {repo: (.repository_url | split("/") | .[-1]), title: .title, url: .html_url}]',
}

local reviewMenu = hs.menubar.new()
local prs = {}

-- Builds the dropdown menu from the latest results. Each click opens the PR url.
local function buildMenu()
  if #prs == 0 then
    return { { title = 'No PRs to review', disabled = true } }
  end

  local items = {}
  for _, pr in ipairs(prs) do
    table.insert(items, {
      title = (pr.repo or '?') .. ': ' .. pr.title,
      fn = function()
        hs.urlevent.openURL(pr.url)
      end,
    })
  end
  return items
end

local function updateTitle()
  reviewMenu:setTitle('👀 ' .. #prs)
end

local function onGhDone(exitCode, stdOut, stdErr)
  if exitCode ~= 0 then
    log:e('reviews: gh exited ' .. exitCode .. ': ' .. (stdErr or ''))
    return
  end

  local ok, decoded = pcall(hs.json.decode, stdOut)
  if not ok or type(decoded) ~= 'table' then
    log:e('reviews: could not parse gh output')
    return
  end

  prs = decoded
  updateTitle()
end

local function refresh()
  hs.task.new(GH, onGhDone, GH_ARGS):start()
end

reviewMenu:setMenu(buildMenu)
updateTitle()

Timers.reviews = hs.timer.doEvery(300, refresh)
refresh()
