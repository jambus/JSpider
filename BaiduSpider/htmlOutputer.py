from datetime import datetime


class HtmlOutputer(object):

    def __init__(self):
        self.datas = []

    def collectData(self, data):
        if data is None:
            return
        self.datas.append(data)

    def outputHtml(self):
        fout = open('./data/output' + str(datetime.now()) + '.html', 'w+')
        fout.write("<html>")
        fout.write("<body>")
        fout.write("<table>")

        for data in self.datas:
            if 'title' in data:
                fout.write("<tr>")
                fout.write('''<td style="width: 25%%;border: solid 1px;" >
                           %s</td><td style="border: solid 1px;">%s</td>'''
                           % (data['title'], data['content']))
                fout.write("</tr>")

        fout.write("</table>")
        fout.write("</body>")
        fout.write("</html>")

        fout.close()
