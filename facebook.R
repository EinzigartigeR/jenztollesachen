# Author: Jens Bruno Wittek

# scrapes the last Fb posts, their like count and more of an arbitrary Facebook page and saves it as a data.frame


# required package
library(Rfacebook)
#!!! Fb token, needs to be generated at https://developers.facebook.com/tools/explorer (attention: will expire soon)
fbtoken = "CAACEdEose0cBAKRZAZAIT5BRvo6ztniFaRlCf5K8dFLNOuHpK09ZAosMFXmmApMmtrIclWezvTGnxcEh9573PZASOKLZA8UU2ZAcYIlzCXJHAAkh56SAzKpv3N7OQZAZCHsNNPrvhre3DTXD8vgG696WA4ePspqkD92oFqTSGl7blL1HggYwO9mCH5umZBtyK2Ko5v0ZBJ3kHEGrY01S0Iv2OZCdPs42F3pzPYZD"
#!!! Fb page, such as https://www.facebook.com/rbloggers
fbname = "rbloggers"
#!!! count of posts you want to scrape
count = 10
# access Fb page
fbpage = getPage(page=fbname,token=fbtoken,n=count)
# init
likescount = commentscount = sharescount = integer(count)
createdtime = posttype = postcontent = character(count)
# function for waiting
wait = function(x) {
  runtime = proc.time()
  Sys.sleep(x)
  proc.time() - runtime
}
# access data
for (i in 1:count) {
  x = getPost(post=fbpage$id[i],n=1,token=fbtoken)
  likescount[i] = x$post$likes_count
  commentscount[i] = x$post$comments_count
  sharescount[i] = x$post$shares_count
  createdtime[i] = x$post$created_time
  posttype[i] = x$post$type
  postcontent[i] = x$post$message
  # wait 5 seconds until next query (otherwise the Fb limit will be reached) - function see above
  wait(5)
}
# save data()(^\\n$)()
output = data.frame(Likes=likescount,Comments=commentscount,Shares=sharescount,Time=createdtime,Type=posttype,Content=postcontent)
output$Content = sub(pattern="\n",replacement="; ",output$Content,fixed=TRUE)
write.table(output,"M://R/Facebook.csv",sep=";",eol="\r",row.names=FALSE,na="")
