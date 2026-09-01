-- typescript-ci-library main module.
--
-- Generates GitHub Actions CI workflows for TypeScript pnpm service archetypes:
--   .github/workflows/build.yaml     — CI build on every push and PR
--   .github/workflows/cut-tag.yaml   — manual workflow_dispatch release tagging
--   .github/workflows/promote.yaml   — manual workflow_dispatch promotion of a release to stg/prd
--
-- Uses p6m-actions: js-pnpm-setup@v1, js-pnpm-build@v1, js-pnpm-cut-tag@v1
--
-- API (called from a parent archetype):
--   local ci = require("typescript-ci")
--   ci.render(context, { destination = context:get("project-name") })
--
-- Standalone retrofit (prompts for project-name if not in context):
--   archetect render .../typescript-ci-library <project-dir>
--
-- Context contract (no required keys — workflows are project-name-agnostic).

local M = {}

-- Render CI workflow files.
-- opts.destination — project subdirectory under the archetect destination root
--   (e.g. "billing-service"). Omit when running standalone with destination
--   already set to the project directory.
function M.render(context, opts)
    opts = opts or {}
    local d = opts.destination
    if d and d ~= "" then
        directory.render("contents", context, { destination = d })
    else
        directory.render("contents", context)
    end
    return context
end

return M
