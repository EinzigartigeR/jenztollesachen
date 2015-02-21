# Author: Jens Bruno Wittek

# scrapes the last Fb posts, their like count and more of an arbitrary Facebook page and saves it as a data.frame


# required package
library(Rfacebook)
#!!! Working direktory
setwd("M://Github/jenztollesachen")
#!!! Fb token, needs to be generated at https://developers.facebook.com/tools/explorer (attention: will expire soon)
fbtoken = "CAACEdEose0cBAJZCHAewF8HmVe9fH0NqC1DfuIuXgHU4xXcjZBXVzZBV42JAFtxPZCB22IuXmXhCL9AZBLwiAz57ammDbvfi7pkQlz3tQrAo1FXAPlDZC2qaMK607gKBbRvuPDj1nfLHzg6Gn8UG9CmOCxDqyOBHYeCUR3fod3jGrrU5fX06IBJZApFuaoGDZApy2Cp8eegFKz1sgL8JvcJnsKlq3PpNsn8ZD"
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
write.table(output,paste("Fb_",fbname,".csv",sep=""),sep=";",eol="\r",row.names=FALSE,na="")


