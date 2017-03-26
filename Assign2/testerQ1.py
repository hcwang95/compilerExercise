# python auto tester
import shlex
from subprocess import Popen, PIPE, STDOUT
import rand_postfix_gen


def test(command_line, inputList):
	args = shlex.split(command_line)
	outputList = []
	p = Popen(args, stdout=PIPE, stdin=PIPE, stderr=STDOUT)
	
	input_ = reduce(lambda x,y : x + y, inputList)
	print(input_)
	output = p.communicate(input=input_)
	return output

def testDriver(command_line, size, length):
	(inputList, oracleList) = rand_postfix_gen.randGen(size, length)
	oracle = reduce(lambda x,y : x+y, list(map(lambda x: '='+x+'\n', oracleList)))
	output = test(command_line, inputList)
	if output[0].replace('BYE!\n','') == oracle:
		print('pass all cases!')
	else:
		print('failed, oracle is:', oracle, '\nwhile output is', output[0])
if __name__ == '__main__':
	command_line = './lrcal_postfix'
	size = 10 #input('test size:')
	length = 10 #input('postfix size')
	testDriver(command_line, size, length)