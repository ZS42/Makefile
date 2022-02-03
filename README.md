# Makefile
Makefiles
Introduction
A Makefile is a file, read by the Make program, which executes all the commands and rules in the Makefile.

Make is kind of a custom build script that makes your programmer-life really easier.

 you’ll be using Makefiles to compile your code, using a compiler.

Generic Makefile
A simple Makefile is composed of your project source files (the .c files) and some rules to make your Make command work.

You have to list your source files like this:

SRC = ./main.c \
      ./file.c
After that, you can use them to build your objects. It will take all .c files in $(SRC) and compile them into .o files.

OBJ = $(SRC:.c=.o)
For the compilation there is a feature that allow you to compile each .c with flags, it’s the +=. For example let’s add verification of errors flags : -Werror -Wextra and a flags to find .h of your project : -I./include. You can call this variable CFLAGS for compilation’s flags.

CFLAGS += -Werror -Wextra -I./include
Be careful !

You don’t have to call this variable in your Makefile, he will solo add it to the compilation of your .c.

Now, set the name of your final binary using NAME, so the AutoGrader can find your binary correctly.

NAME = binary_name
Then, it is mandatory to create a $(NAME) rule that will execute other rules, and render a binary.

$(NAME): $(OBJ)
         gcc -o $(NAME) $(OBJ)

all:     $(NAME)
Pro-tip

When you have a rule like $(NAME), the rules put in the same line will be used as mandatory rules. After those rules have been called, the command on the next lines will be called.

For instance, this will execute the ls command without executing any previous rule.

list:
      ls
You can also have some rules that permit you to clean-up your folder without having to do it manually.

For instance, this clean will remove .o files. Also, fclean will remove .o files and the binary. re will do fclean and re-make your binary.

clean:
        rm -f $(OBJ)

fclean: clean
        rm -f $(NAME)

re:     fclean all
Don’t forget to put a .PHONY, in order to avoid relinking. Put all the rules you use.

.PHONY: all clean fclean re


How Makefile works:
First goes to all and then solves dependencies
So in Libft all depends on ${NAME} which depends on ${OBJS} which conver5ts SRC from .c to .o using %.o:%.c and tis uses flags and then goes back to do rest of {NAME}


$(NAME): $(OBJ)
         gcc -o $(NAME) $(OBJ)
         means         
target: dependency1 dependency 2
<tab> command
      
