# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: zsyyida <zsyyida@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/10/23 15:19:20 by zsyyida           #+#    #+#              #
#    Updated: 2022/01/31 15:57:01 by zsyyida          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libft.a
 
SRCS = ft_isdigit.c ft_memset.c ft_isprint.c ft_itoa.c ft_strtrim.c \
		ft_putchar_fd.c ft_strlcat.c ft_substr.c ft_atoi.c \
		ft_putendl_fd.c ft_strlcpy.c ft_tolower.c ft_bzero.c \
		ft_putnbr_fd.c ft_strlen.c ft_toupper.c ft_calloc.c ft_memchr.c \
		ft_putstr_fd.c ft_strmapi.c ft_isalnum.c ft_memcmp.c \
		ft_strncmp.c ft_isalpha.c ft_memcpy.c ft_strchr.c ft_strnstr.c \
		ft_isascii.c ft_memmove.c ft_strdup.c ft_strrchr.c ft_strjoin.c \
		ft_split.c ft_striteri.c
 
BONUS = ft_lstadd_back.c ft_lstadd_front.c ft_lstclear.c ft_lstdelone.c \
 		ft_lstiter.c ft_lstlast.c ft_lstnew.c ft_lstsize.c ft_lstmap.c 

OBJS = ${SRCS:.c=.o}
 
OBJSBONUS = ${BONUS:.c=.o}
 
CC		= gcc
RM		= rm -f
 
CFLAGS = -Wall -Wextra -Werror
 
%.o: %.c
			${CC} ${CFLAGS} -c $< -o $@
 
$(NAME): ${OBJS}
				ar rcs ${NAME} ${OBJS}
 
bonus: ${OBJSBONUS}
				ar rcs ${NAME}  ${OBJSBONUS}
 
all:			${NAME}
 
clean:
				${RM} ${OBJS} ${OBJSBONUS}
 
fclean:	clean
				${RM} ${NAME}
 
re:				fclean all

rebonus:		fclean bonus

.PHONY:		all clean fclean re rebonus

