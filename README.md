# teammanse

## Bundle app for GitHub pages
```
# update app: you may have to delete the docs/ dir
shinylive::export(appdir = "app", destdir = "docs")
# serve locally
httpuv::runStaticServer("./docs", headers = c(`Access-Control-Allow-Origin` = "*"))
```
