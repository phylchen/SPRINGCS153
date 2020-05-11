#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]) {

int pid = fork();
int exitStatus;
int waitpidStatus = 0;

	if(pid == 0) { //child process
		printf(1, "Child process: PID %d; Exit status %d \n", getpid(),getpid() + 1);
		exit(getpid() + 1);
	}
	else {
		waitpidStatus = waitpid(pid, &exitStatus, 0);
		printf(1, "Parent process w/ child process PID %d \n", pid);
	}

	printf(1, "waitpid status: %d \n", waitpidStatus);
	
	exit(0);

	return 0;
}
