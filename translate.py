# 导入requests模块
# 如果有新手不懂的可以在命令指示符窗口中输入pip install requests命令即可
import requests
# 定义main函数（学C的眼熟吧）
# 但是这就是一个普通的函数，和C中的不一样


def main():
    # 使用try语句让程序捕获异常后不会退出
    try:
        # 循环，感觉没人不懂
        while 1:
            # 使用input函数获取用户输入，并且导入变量word
            word = input('请输入翻译的内容：')
            # 把有道翻译的URL储存在这个字符串里
            url = 'https://fanyi.baidu.com/#zh/en'
            # 定义下载回来的翻译形式是以字典呈现
            data = {'i': word, 'doctype': 'json'}
            # headers可以防止爬虫被有道识别出来
            # headers可以在审查元素-->网络 里找到，大家应该懂
            #header = {'User-Agent': 'Mozilla/5.0'}
            header = {
            "User-Agent":
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.69"
}
            # 使用post请求，把get到的东西封装在response里
            response = requests.post(url, data=data, headers=header)
            # 把数据用JSON解析出来，本人也不太懂
            # 有兴趣的可以看看这个：
            # https://blog.csdn.net/qq_41684621/article/details/113851644
            reply = response.json()['translateResult'][0][0]['tgt']
            # 将翻译的内容打印出来并换行
            print(reply+'\n')
            # 这里可以多加一个input函数，让用户多敲击一下enter键
            # input()
    # 捕获操作异常，并且输出提示后重新循环
    except OSError:
        print('请输入内容！\n')
        # 此处如上同理
        # input()

    # 捕获异常退出
    except KeyboardInterrupt:
        # print('退出程序?')
        # 这里本人多加了一个判定，感觉没啥实用价值
        _ii = input('退出程序?(y/n)')
        if _ii == 'y':
            exit()
        else:
            pass

    # 捕获剩下的异常，这些异常应该都是网络问题
    # 这里写得不太严谨，希望大家可以帮忙改改
    except Exception:
        print('网络错误，请检查网络配置\n')
        # input()
        # pass


# 这本来是一个可以防止别人把这个程序当成模块调用的东西
# 感觉看着不顺眼，注释了，如有需要可以去掉注释

if __name__ == "__main__":
    while 1:
        main()
