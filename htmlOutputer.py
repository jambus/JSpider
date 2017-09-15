class HtmlOutputer(object):

    def __init__(self):
        self.datas = []

    def collectData(self, data):
        if data is None:
            return
        self.datas.append(data)

    def outputHtml(self):
        fout = open('output.html', 'w')
        fout.write("<html>")
        fout.write("<body>")
        fout.write("<table>")

        for data in self.datas:
            if 'title' in data:
                fout.write("<tr>")
                fout.write("<td>%s</td>" % data['title'])
                fout.write("</tr>")

        fout.write("</table>")
        fout.write("</body>")
        fout.write("</html>")

        fout.close()
