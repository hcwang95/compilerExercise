# python auto tester
import shlex
from subprocess import Popen, PIPE, STDOUT
import rand_postfix_gen


def test(command_line, input):
	args = shlex.split(command_line)
	p = Popen(args, stdout=PIPE, stdin=PIPE, stderr=STDOUT)
	output = p.communicate(input=input)
	return output

def testDriver(command_line, size, length):
	(inputList, oracleList) = rand_postfix_gen.randGen(size, length)
	oracleList = list(map(lambda x: '='+x+'\n', oracleList))
	for i in inputList:
		output = test(command_line, i)
		if output[0]!=oracleList[inputList.index(i)]:
			print('Failed at case:', i, '\noutput is:', output, '\nexpected output is', oracleList[inputList.index(i)])
			break
if __name__ == '__main__':
	command_line = './rdcal_postfix'
	size = 100#input('test size:')
	length = 100 #input('postfix size')
	testDriver(command_line, size, length)