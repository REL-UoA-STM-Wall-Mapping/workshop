/*
	file_watch_1.cpp
		Read a temporally file 10 times with 1 sec interval 
			Author: Keitaro Naruse
			Data: 2020-06-18
 */

#include <chrono>
#include <cstdio>
#include <iostream>
#include <string>
#include <thread>

bool loop_flag;

void	file_watch()
{
	const std::string filename = "/tmp/tmp.wm.id.txt";
	FILE *fp;
	char buf[8];
	
	while(loop_flag)	{
		fp = fopen(filename.c_str(), "rt");
		if(NULL != fp)	{
			fread(buf, sizeof(char), 8, fp);
			std::cerr << buf << std::endl;
			remove(filename.c_str());
		}
		std::this_thread::sleep_for(std::chrono::seconds(1));
	}
}

	

int main()
{
	loop_flag = true;

	std::thread th1(file_watch);
	std::string input_string;
	
	std::cout << "Enter [y] if you want to stop it" << std::endl;
	
	while(1)	{
		std::cin >> input_string;
		std::cout << input_string << std::endl;
		if("y" == input_string)	{
			loop_flag = false;
			break;
		}
	}
	th1.join();
	std::cerr << "Normally terminated" << std::endl;
	
	return(0);
}

