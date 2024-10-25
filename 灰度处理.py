#加权平均法
import cv2  
  
# 读取彩色图像  
img = cv2.imread('color_image.jpg')  
  
# 将彩色图像转换为灰度图像  
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  
  
# 显示灰度图像  
cv2.imshow('Gray Image', gray_img)  
cv2.waitKey(0)  
cv2.destroyAllWindows()

  import numpy as np  
  
# 读取彩色图像  
img = np.array(cv2.imread('color_image.jpg'))  
  
# 获取图像的高度、宽度和通道数  
height, width, channels = img.shape  
  
# 计算加权平均值作为灰度值  
gray_img = (0.299 * img[:, :, 0] + 0.587 * img[:, :, 1] + 0.114 * img[:, :, 2]) / (0.299 + 0.587 + 0.114)  
  
# 将灰度值限制在0-255范围内  
gray_img = np.clip(gray_img, 0, 255)  
  
# 将灰度值转换为整数  
gray_img = gray_img.astype(np.uint8)  
  
# 显示灰度图像  
cv2.imshow('Gray Image', gray_img)  
cv2.waitKey(0)  
cv2.destroyAllWindows()


  #最大值法
import cv2  
import numpy as np  
  
# 读取彩色图像  
img = cv2.imread('color_image.jpg')  
  
# 获取图像的高度、宽度和通道数  
height, width, channels = img.shape  
  
# 创建一个空的灰度图像  
gray_img = np.zeros((height, width), dtype=np.uint8)  
  
# 遍历图像的每个像素  
for i in range(height):  
    for j in range(width):  
        # 获取当前像素的RGB值  
        r, g, b = img[i, j]  
          
        # 使用最大值法计算灰度值  
        gray_value = max(r, g, b)  
          
        # 将灰度值赋给灰度图像的当前像素  
        gray_img[i, j] = gray_value  
  
# 显示灰度图像  
cv2.imshow('Gray Image', gray_img)  
cv2.waitKey(0)  
cv2.destroyAllWindows()

  #分量法
import cv2  
  
# 读取彩色图像  
img = cv2.imread('color_image.jpg')  
  
# 获取图像的高度、宽度和通道数  
height, width, channels = img.shape  
  
# 选择一个通道作为灰度值，这里选择B通道  
gray_img = img[:, :, 0]  
  
# 显示灰度图像  
cv2.imshow('Gray Image', gray_img)  
cv2.waitKey(0)  
cv2.destroyAllWindows()

  #平均值法
import cv2  
  
# 读取彩色图像  
img = cv2.imread('color_image.jpg')  
  
# 获取图像的高度、宽度和通道数  
height, width, channels = img.shape  
  
# 计算R、G、B三个通道的平均值作为灰度值  
gray_img = cv2.mean(img)  
  
# 显示灰度图像  
cv2.imshow('Gray Image', gray_img)  
cv2.waitKey(0)  
cv2.destroyAllWindows()
