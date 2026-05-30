# teammanse

## Bundle app for GitHub pages
```
# You may have to delete the `docs` folder after making changes before running `shinylive::export()`
shinylive::export(appdir = "app", destdir = "docs")
usethis::use_github_action(url="https://github.com/posit-dev/r-shinylive/blob/actions-v1/examples/deploy-app.yaml")
httpuv::runStaticServer("./docs", headers = c(`Access-Control-Allow-Origin` = "*"))
```
