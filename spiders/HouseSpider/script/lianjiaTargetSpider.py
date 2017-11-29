#!/usr/bin/env python
# Project: lianjia_target
# Desc: Specific requirement and dig results

import urllib.parse as urlparse

from pyspider.libs.base_handler import *


class LianJiaTargetHandler(BaseHandler):
    crawl_config = {
    }

    def __init__(self):
        self.rootUrl = 'http://sh.lianjia.com/ershoufang/b180to300l1l2m45to90o1s20'

    @every(minutes=24 * 60)
    def on_start(self):
        self.crawl(self.rootUrl,
                   callback=self.index_page)

    @config(age=7 * 24 * 60 * 60)
    def index_page(self, response):
        # Get area links
        # for each in response.doc('a.level1-item,div.level1-item>a,div.level2-item>a').items():
        #    newFullUrl = urlparse.urljoin(self.rootUrl, each.attr.href)
        #    self.crawl(newFullUrl, callback=self.index_page)

        # Get house content list
        for each in response.doc('a.js_fanglist_title').items():
            newFullUrl = urlparse.urljoin(self.rootUrl, each.attr.href)
            self.crawl(newFullUrl, callback=self.detail_page)

        # Navigate next page
        nextButton = response.doc('a[gahref=results_next_page]')
        if nextButton is not None:
            newFullUrl = urlparse.urljoin(self.rootUrl, nextButton.attr.href)
            self.crawl(newFullUrl, callback=self.index_page)

    @config(priority=2, age=7 * 24 * 60 * 60)
    def detail_page(self, response):
        return {
            "url": response.url,
            "title": response.doc('h1.header-title').text(),
            "totalprice": response.doc('.price-total').text(),
            "pricePerUnit": response.doc('.price-unit-num').text(),
            "houseType": response.doc('.maininfo-main>li:first>:first').text(),
            "finishType": response.doc(
                '.maininfo-main>li:first>:nth-child(2)').text(),
            "houseDirect": response.doc(
                '.maininfo-main>li:nth-child(2)>div>:first').text(),
            "floor": response.doc(
                '.maininfo-main>li:nth-child(2)>div>:nth-child(2)').text(),
            "area": response.doc(
                '.maininfo-main>li:nth-child(3)>:first').text(),
            "houseAge": response.doc(
                '.maininfo-main>li:nth-child(3)>:nth-child(2)').text(),
            "address": response.doc('.maininfo-estate-name').text(),
            "houseNumber": response.doc(
                '.maininfo-minor>li:last>span:nth-child(2)').text()
            .split(' ', 2)[0],
            "houseCardAge": response.doc(
                '.module-row:nth-child(2) .baseinfo-col2 li:nth-child(2)>:nth-child(2)').text(),
            "houseUsageType": response.doc(
                '.module-row:nth-child(2) .baseinfo-col3 li:nth-child(2)>:nth-child(2)').text(),
        }
