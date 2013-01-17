
## 在 Github 写静态博客

还真离不开 Markdown 了, 文本写这儿, 关于在 Github 上的静态博客
至少我学了 JS 知道 Github 的 Pages 可用, 当然是自己想写个博客
以前也在上边看到有牛人的中文博客, 仅仅是 Github 静态页面
当时发现原来还有 HTTP 请求来获取博文内容的思路,
这不难, 但我经验不足, 当时算开了眼界, 而且也想不出来
一个特别明显的问题是需要手动生成目录, 这挺麻烦的

模仿 Jekyll 生成静态文件的方法, 网上挺多的, 可我觉得挺没意思
毕竟写完博客还要一边生成一边看效果, 这很繁琐对吧
我的思路是文件应该能几乎实时预览, 这是趋势
后来突然想到, 如果能获取文件列表, 问题就不大了
比如 Nginx, 对文件使用索引, 这样就能被 JS 识别到了
我莽撞地往 Github 反馈邮件, 结果回复我说, 直接用 API 就可以了
于是有了这个 repo 的试验, 链接在下边:
http://jiyinyiyong.github.com/github-viewer/page/

邮件里提到一个是 API 里的 `content`, 了一获取内容:
http://developer.github.com/v3/repos/contents/
接着是 JSONP 或这 CORS 可以解决跨域问题:
http://developer.github.com/v3/#cross-origin-resource-sharing
我懒得用 jQuery, 写 JSONP 不方便, 于是吊死在 CORS 了
经过本地调试, 没有问题, 结果到了网页上就搞不定了
今天才发现是需要注册一个对应域名的 Github 应用, 搞定

里边基本上是 API 的应用, 用 GET 请求, 获取 JSON 或纯文本
页面主体部分没有优化, 短期我也不打算真的用这个做博客了
还有取出 History API, 用起来不难, 只在 Chrome 跑的话
http://www.clanfei.com/2012/09/1646.html
这样, 博客需要的网址也有了, 代码量也很少
当然我的代码用来做教学不够好, 代码分离也不够清晰
主要是证明能用, 譬如这篇文章就是希望放在页面里的
另外评论和标签我没有尝试去解决, 那就难一些了
