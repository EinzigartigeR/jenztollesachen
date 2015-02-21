# Author: Jens Bruno Wittek

# scrapes the last Fb posts, their like count and more of an arbitrary Facebook page and saves it as a data.frame


# required package
library(Rfacebook)
#!!! Fb token, needs to be generated at https://developers.facebook.com/tools/explorer (attention: will expire soon)
fbtoken = "CAACEdEose0cBAGGBkRQw1ZCqHiAjRICAekwGk8vmBPkhsg4YNlPKWFc8IgNcFdga3KyDDTMkh5OSiO5bqGWBj2q9NQBNHSahzEyNGMAkZAFWTivJQlNcuKp61wSKdLCszwY4daoZCNmWAo0FnpImEb7otFNgZAnCTKf9bumOSMaW05lxNYH2Ex3ZACbBMYMRdgs1eVfKOhMj9FzLxA7c2N3uZBrVBdN6IZD"
#!!! Fb page, such as https://www.facebook.com/rbloggers
fbname = "rbloggers"
#!!! count of posts you want to scrape
count = 10
# access Fb page
fbpage = getPage(page=fbname,token=fbtoken,n=count)
# init
output = data.frame(matrix(ncol=6,nrow=count))
names(output) = c("Likes","Comments","Shares","Time","Type","Content")
# function for waiting
wait = function(x) {
  runtime = proc.time()
  Sys.sleep(x)
  proc.time() - runtime
}
# access data
for (i in 1:count) {
  x = getPost(post=fbpage$id[i],n=1,token=fbtoken)
  output$Likes[i] = x$post$likes_count
  output$Comments[i] = x$post$comments_count
  output$Shares[i] = x$post$shares_count
  output$Time[i] = x$post$created_time
  output$Type[i] = x$post$type
  output$Content[i] = x$post$message
  # wait 5 seconds until next query (otherwise the Fb limit will be reached) - function see above
  wait(5)
}
# save data
output$Content = gsub(pattern="\n",replacement="; ",output$Content,fixed=TRUE)
write.table(output,"M://Github/Facebook.csv",sep=";",eol="\r",row.names=FALSE,na="")


