#!/usr/bin/env python3

import sys

from urlManager import UrlManager
from htmlDownloader import HtmlDownloader
from htmlParser import HtmlParser
from htmlOutputer import HtmlOutputer


class HouseSpider(object):

    def __init__(self):
        self.urls = UrlManager()
        self.downloader = HtmlDownloader()
        self.parser = HtmlParser()
        self.outputer = HtmlOutputer()

    def craw(self, rootUrl):

        print ('Start craw...')
        count = 1
        self.urls.addNewUrl(rootUrl)

        while self.urls.hasNewUrl():
            try:
                newUrl = self.urls.getNewUrl()
                print ('craw %d:%s' % (count, newUrl))
                htmlContent = self.downloader.download(newUrl)
                newUrls, newData = self.parser.parse(newUrl, htmlContent)

                self.urls.addNewUrls(newUrls)
                self.outputer.collectData(newData)
            except BaseException as argument:
                print ('craw failed', argument)

            count = count + 1
            if count > 10:
                break

        self.outputer.outputHtml()
        print ('End craw...')


def main():
    rootUrl = 'https://baike.baidu.com/'
    spider = HouseSpider()
    spider.craw(rootUrl)
    pass


main()
