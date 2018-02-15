# elm-page-rank

Install all dependencies using the handy `reinstall` script:
```
npm run reinstall
```
*This does a clean (re)install of all npm and elm packages, plus a global elm install.*


### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/elm/Main.elm`
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To check it, open `dist/index.html`


### Credits
This project was:
* created using the [elm-webpack-starter](https://github.com/elm-community/elm-webpack-starter.git)
* inspired by [Sascha Grau's](http://www.graui.de/) [interactive page rank example](http://www.graui.de/pageRank.htm)
