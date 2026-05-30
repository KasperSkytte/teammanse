# teammanse

## Bundle app for GitHub pages
```
# update app: you may have to delete the docs/ dir
shinylive::export(appdir = "app", destdir = "docs")
# only run once:
usethis::use_github_action(url="https://github.com/posit-dev/r-shinylive/blob/actions-v1/examples/deploy-app.yaml")
# serve locally
httpuv::runStaticServer("./docs", headers = c(`Access-Control-Allow-Origin` = "*"))
```
