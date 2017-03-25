# random postfix generator

import random
import helpful_string
digits = '0123456789'
operator = ['+','-','*','/']
firstOp = ['*', '/']
secondOp = ['+','-']

def popCond(instack, incoming, count):
	if count < 2:
		return False
	else:
		if instack in firstOp:
			return True
		elif incoming in secondOp:
			return True
		else:
			return False
	
def randOp():
	return {0: '+',
			1: '-',
			2: '*',
			3: '/'}[random.randint(0, 3)]

def generateInfix(length):
	infixStr = ''
	for i in range(length-1):
		infixStr += str(random.randint(1, 99))+randOp()
	infixStr+=str(random.randint(1, 99))
	# print('generate new infix:', infixStr)
	return infixStr


def evaluateInfix(infixStr):
	# print('evaluate' , infixStr, '=', eval(infixStr))
	return str(eval(infixStr))


def generatePostfix(infixStr):
	postfixStr =''
	opStack = []
	count = 0
	cumulative_int = ''
	for i in infixStr:
		if i in helpful_string.digits:
			cumulative_int+=i

		elif i in operator:
			if cumulative_int != '':
				postfixStr+=cumulative_int+' '
				count +=1
				cumulative_int=''
			try:
				while (len(opStack)!=0):
					if popCond(opStack[-1], i, count):
						op = opStack.pop()
						postfixStr+=op+' '
						count-=1
					else:
						break
			except:
				pass
			opStack.append(i)
			# print(opStack)
	if cumulative_int!= '':
		postfixStr+= cumulative_int+' '
		cumulative_int = ''
	if len(opStack)!=0:
		for i in opStack[::-1]:
			postfixStr+= i+' '
	# print('postfixStr:', postfixStr)
	return postfixStr

def randGen(size, length):
	inputStrs = []
	oracleStrs = []
	for i in range(size):
		infixStr = generateInfix(length)
		oracleStrs.append(evaluateInfix(infixStr))
		inputStrs.append(generatePostfix(infixStr)+'\n')
	return (inputStrs, oracleStrs)

if __name__ == '__main__':
	fileStreamInput = open('testInput.txt','w')
	fileStreamOutput = open('expectedOutput.txt','w')
	for i in range(10):
		infixStr = generateInfix(5)
		fileStreamOutput.write(evaluateInfix(infixStr)+'\n')
		fileStreamInput.write(generatePostfix(infixStr)+'\n')




