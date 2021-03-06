
log = -> console?.log? arguments...
delay = (f, t) -> setTimeout t, f
q = (query) -> document.querySelector query
Node.prototype.q = (query) -> @querySelector query
Object.getOwnPropertyNames(Array.prototype).forEach (prop) ->
  if Array.prototype[prop]?
    if (typeof Array.prototype[prop]) is "function"
      NodeList.prototype[prop] = Array.prototype[prop]

user = "jiyinyiyong"
if location.hash.match /#\w+/
  user = location.hash.match(/#(\w+)/)[1]
auth = "client_id=...&client_secret=..."
auth = ""

root = (username, reponame) ->
  "https://api.github.com/repos/#{username}/#{reponame}/contents/"

get = (path, callback) ->
  req = new XMLHttpRequest
  log "get:", path
  if path.indexOf("?") >= 0
    the_path = path + "&" + auth
    # log "the_path", the_path
    req.open "get", the_path
  else
    the_path = path + "?" + auth
    # log "the_path", the_path
    req.open "get", the_path
  req.onload = (res) ->
    text = res.target.response
    callback JSON.parse text
  req.send()

get_raw = (path, callback) ->
  req = new XMLHttpRequest
  # log "get:", path
  if path.indexOf("?") >= 0
    the_path = path + "&" + auth
    log "the_path", the_path
    req.open "get", the_path
  else
    the_path = path + "?" + auth
    log "the_path", the_path
    req.open "get", the_path
  req.setRequestHeader "Accept", "application/vnd.github.VERSION.raw"
  req.onload = (res) ->
    text = res.target.response
    callback text
  req.send()

window.onload = ->
  el =
    list: q "#list"
    user: q "#user"
    page: q "#page"

  marked.setOptions
    breaks: yes


  get_user = (username) ->
    get "https://api.github.com/users/#{username}", (data) ->
      # log data
      el.user.q(".profile").innerHTML = ''
      el.user.q(".profile").appendChild lilyturf.dom ->
        @div {},
          @img src: data.avatar_url
          @div class: "username", (@text data.name)
          @div class: "location", (@text data.location)

  get_user user

  get_repo = (username) ->
    # repo_url "https://api.github.com/users/#{username}/repos"
    repo_url = "https://api.github.com/users/#{username}/repos"
    repo_url+= "?type=owner&sort=updated"
    get repo_url, (data) ->
      # log data
      data.forEach (repo) ->
        elem = lilyturf.dom ->
          @div class: "repo",
            @p class: "repo-name", (@text repo.name)
            @p class: "description", (@text repo.description)
        el.user.q(".repos").appendChild elem

        elem.onclick = ->
          # log repo.contents_url
          el.list.q(".repo").innerText = repo.name
          el.list.q(".path").innerText = ""
          contents = repo.contents_url.replace("{+path}", "")

          get contents, render_list
          el.list.q(".repo").onclick = ->
            get contents, render_list

  get_repo user

  render_list = (list) ->
    el.list.q(".list").innerHTML = ""
    list.forEach (file) ->
      elem = lilyturf.dom ->
        @div class: file.type, (@text file.name)
      el.list.q(".list").appendChild elem

      elem.onclick = ->
        log "click:", file
        el.list.q(".path").innerText = file.path
        if file.type is "dir"
          get file.url, render_list
        else
          get_raw file.url, (text) ->
            render_file text, file.path

        repo = file.url.match(/repos\/[\w\d-]+\/([\w\d-]+)\//)[1]
        state =
          user: user
          repo: repo
          path: file.path
        history.pushState state, file.path, "##{user}/#{repo}/#{file.path}"

  render_file = (text, path) ->
    # log "file:", text
    page.innerHTML = ""
    if path.match /\w+\.(md)$/
      page.innerHTML = marked text
    else if path.match /\w+\.(png)|(jpg)|(jpeg)|(gif)$/i
      # page.appendChild lilyturf.dom ->
      #   @img src: (btoa text)
      page.innerText = "Images are not available"
    else
      page.appendChild lilyturf.dom ->
        @pre {},
          @code {},(@text text)

  window.onpopstate = (pop) ->
    log 'onpopstate', pop.state
    state = pop.state
    if state?
      get_user state.user

      start = root state.user, state.repo
      get start, render_list
      get_raw (start + state.path), (text) ->
        render_file text, state.path

  if location.hash?
    string = location.hash[1..]
    match = string.match(/^([\w\d-]+)\/([\w\d-]+)\/(\S+)$/)[1..]
    pop =
      state:
        user: match[0]
        repo: match[1]
        path: match[2]
    log match, pop
    onpopstate pop
