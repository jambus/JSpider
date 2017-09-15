import re
import urllib.parse as urlparse

from bs4 import BeautifulSoup


class HtmlParser(object):

    def parse(self, pageUrl, htmlContent):
        if pageUrl is None or htmlContent is None:
            return
        soup = BeautifulSoup(htmlContent, 'html.parser', from_encoding='utf-8')
        newUrls = self._getNewUrls(pageUrl, soup)
        newData = self._getNewData(pageUrl, soup)
        return newUrls, newData

    def _getNewUrls(self, pageUrl, soup):
        newUrls = set()

        links = soup.find_all('a', href=re.compile(r"/item/.+/\d+"))
        for link in links:
            newUrl = link['href']
            newFullUrl = urlparse.urljoin(pageUrl, newUrl)
            newUrls.add(newFullUrl)

        return newUrls

    def _getNewData(self, pageUrl, soup):
        resData = {}
        titleNode = soup.find('dd',
                              class_="lemmaWgt-lemmaTitle-title")
        if titleNode is not None:
            titleNode = titleNode.find("h1")
            resData['title'] = titleNode.get_text()

        contentNode = soup.find('div',
                                class_="lemma-summary")
        if contentNode is not None:
            resData['content'] = contentNode.get_text()

        return resData
