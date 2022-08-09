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
Don’t forget to put a .PHONY, in order to avoid relinking. Put all the rules you use.A phony target is one that is not really the name of a file; rather it is just a name for a recipe to be executed when you make an explicit request. There are two reasons to use a phony target: to avoid a conflict with a file of the same name, and to improve performance.A phony target is one that isn't really the name of a file. It will only
have a list of commands and no dependencies. 
.PHONY: all clean fclean re


How Makefile works:
First goes to all and then solves dependencies
So in Libft all depends on ${NAME} which depends on ${OBJS} which conver5ts SRC from .c to .o using %.o:%.c and tis uses flags and then goes back to do rest of {NAME}


$(NAME): $(OBJ)
         gcc -o $(NAME) $(OBJ)
         means         
target: dependency1 dependency 2
<tab> command
 
 https://www.tutorialspoint.com/makefile/makefile_quick_guide.htm    
 
 $< the name of the related file that caused the action.
  $@ is the name of the file to be made. 
       
       $@ is the name of the target being generated, and $< the first prerequisite (usually a source file)
 
 
  Both ${CC} and $(CC) are valid references to call gcc. But if one tries to reassign a variable to itself, it will cause an infinite loop. Let's verify this:

CC = gcc
CC = ${CC}

all:
    @echo ${CC}
Running make will result in:

$ make
Makefile:8: *** Recursive variable 'CC' references itself (eventually).  Stop.
To avoid this scenario, we can use the := operator (this is also called the simply expanded variable). We should have no problem running the makefile below:

CC := gcc
CC := ${CC}

all:
    @echo ${CC}
 
 %.o: %.c
        $(CC) -c $^ -o $@  
is a pattern rule, which is a type of implicit rule. It specifies one target and one dependency, and causes one invocation of $(CC) for each target. (does % indicate pattern rule???? )

 
 
 To substitute a variable's value, write a dollar sign followed by the name of the variable in parentheses or braces: either `$(foo)' or `${foo}' is a valid reference to the variable foo. This special significance of `$' is why you must write `$$' to have the effect of a single dollar sign in a file name or command.
 
 rm is for remove -f‘ option in rm command will remove or delete the files forcefully regardless of its permissions and will also ignore non-existing files. In case of directories use rm -rf
 
 Reading the manual for ar helps but I will explain it in more detail. ar -rcs is the most likely command you would use when using a Makefile to compile a library. r means that if the library already exists, replace the old files within the library with your new files. c means create the library if it did not exist. s can be seen to mean 'sort' (create a sorted index of) the library, so that it will be indexed and faster to access the functions in the library. Therefore, rcs can be seen to mean replace, create, sort.  
 ADDING LIBRARY TO MAKEFILE
 Make sure that the -L option appears ahead of the -l option; the order of options in linker command lines does matter, especially with static libraries. The -L option specifies a directory to be searched for libraries (static or shared). The -lname option specifies a library which is with libmine.a (static) or libmine.so (shared on most variants of Unix, but Mac OS X uses .dylib and HP-UX used to use .sl). Conventionally, a static library will be in a file libmine.a. This is convention, not mandatory, but if the name is not in the libmine.a format, you cannot use the -lmine notation to find it; you must list it explicitly on the compiler (linker) command line.
 [
]

(https://stackoverflow.com/questions/11344965/how-to-include-static-library-in-makefile)
OBJECTS       := $(addprefix $(OBJDIR)/,$(SOURCES:.cpp=.o))
to ensure that the directory is applied to each word individually, not just pasted to the front of the first word.

#  goes to file -L
#  looks for library -l .All libraries have lib so ft

 The one thing you must NEVER do is use a directory as a simple prerequisite. The rules the filesystem uses to update the modified time on directories do not work well with make.
For simple make on a POSIX system, you can pre-create the directory in the rule to perform the compilation:

obj/foo.o: foo.c
        @ mdkir -p obj
        $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
