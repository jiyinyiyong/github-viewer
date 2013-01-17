
# Github viewer is a tool for reading repos

### Demo

Visit: http://jiyinyiyong.github.com/github-viewer/page/ to see it.  

The division on top is the user profile. The right one is file list.  
Mouse turning to hand means you can click here..  
Append a hash tag `#jiyinyiyong` to specify the username.  

It's totally an exercise for Github API. It's nice.  

I reached Github API's limit and I tried to use an application key.  
..That's it.

### Goal

Just a test if I can generate a static blog with file free lists..  
Think about it, push `.md` files to Github Pages without regenerating index,  
and then use Github API to read the file lists, then it's already a blog.  
Then it will be a really simple way to host your blog on Github.  

##### How to?

In this repe, I show most techniques required for a blog like that.  
Github API, CORS, History API are the neccessary.  
I just suppose you have know you have used Github Pages before.  
http://pages.github.com/

First, creata a Github Application, make it available for CORS.  
Click here: https://github.com/settings/applications/new  
And create a repo with a `gh-pages` branch, which means pages.  
Then write your code to handle Github API.  
Sounds boring? Read `post/blog-on-github.md` if you speak Chinese.  

### Reference

Github's APIs:  
http://developer.github.com/

Prefers Lilyturf as templating tool:  
http://jiyinyiyong.github.com/lilyturf/page/  

Thanks to marked:  
https://github.com/chjj/marked

History API from Mozilla's docs:  
https://developer.mozilla.org/zh-CN/docs/DOM/Manipulating_the_browser_history  
https://developer.mozilla.org/zh-CN/docs/DOM/window.onpopstate  

### License

MIT