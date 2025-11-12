import requests
from bs4 import BeautifulSoup

headers = {
    "User-Agent":
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.69"
}
i=1
for start_num in range(0,250,25):

    html = requests.get(f"https://movie.douban.com/top250?start={start_num}", headers=headers).text
    soup = BeautifulSoup(html, "html.parser")  # "html.parser"->解析器
    titles=soup.findAll("span",attrs={"class":"title"})
    
    for title in titles:
        title_string=title.string
        if "/" not in title_string:
            print(i,title_string)
            i+=1
    i=i
    
