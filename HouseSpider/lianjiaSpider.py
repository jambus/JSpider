import urllib.parse as urlparse

from pyspider.libs.base_handler import *


class LianJiaHandler(BaseHandler):
    crawl_config = {
    }

    def __init__(self):
        self.rootUrl = 'http://sh.lianjia.com/ershoufang'
        self.count = 0

    @every(minutes=24 * 60)
    def on_start(self):
        self.crawl(self.rootUrl,
                   callback=self.index_page)

    @config(age=10 * 24 * 60 * 60)
    def index_page(self, response):

        for each in response.doc('a.js_fanglist_title').items():
            newFullUrl = urlparse.urljoin(self.rootUrl, each.attr.href)
            self.crawl(newFullUrl, callback=self.detail_page)

        nextButton = response.doc('a[gahref=results_next_page]')
        if nextButton is not None:
            newFullUrl = urlparse.urljoin(self.rootUrl, nextButton.attr.href)
            self.crawl(newFullUrl, callback=self.index_page)

    @config(priority=2)
    def detail_page(self, response):
        return {
            "url": response.url,
            "title": response.doc('h1.header-title').text(),
            "totalprice": response.doc('.price-total').text(),
            "pricePerUnit": response.doc('.price-unit-num').text(),
            "houseType": response.doc('.maininfo-main>li:first>:first').text(),
        }
