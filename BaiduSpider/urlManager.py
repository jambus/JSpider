class UrlManager(object):

    def __init__(self):
        self.newUrls = set()
        self.oldUrls = set()

    def addNewUrl(self, url):
        if url is None:
            return

        if url not in self.newUrls and url not in self.oldUrls:
            self.newUrls.add(url)

    def hasNewUrl(self):
        return len(self.newUrls) != 0

    def getNewUrl(self):
        newUrl = self.newUrls.pop()
        self.oldUrls.add(newUrl)
        return newUrl

    def addNewUrls(self, urls):
        if urls is None or len(urls) == 0:
            return
        for url in urls:
            self.addNewUrl(url)
