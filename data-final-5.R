#각 패키지 장착
#library(rpart) #결정
#library(randomForest) #포레스트
#library(e1071) #SVM
#library(caret) #혼돈행렬
#library(class) #K-NN

#데이터를 변수에 저장
ucla = read.csv('http://stats.idre.ucla.edu/stat/data/binary.csv')

#(준비과정)Label 인 admin을 factor로 변환 회귀가 아닌 분류로 실행하기 위해
ucla$admit = factor(ucla$admit)

#sample 함수를 통해 6:4로 분류
idx = sample(1:nrow(ucla),nrow(ucla)*0.6)
train = ucla[idx,]
test = ucla[-idx,]
#개수확인
nrow(train)
nrow(test)