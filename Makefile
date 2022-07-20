# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: apigeon <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/30 16:08:04 by apigeon           #+#    #+#              #
#    Updated: 2022/07/20 18:44:13 by apigeon          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


### COMPILATION ###
CC		= cc
CFLAGS	= -Wall -Werror -Wextra
LFLAGS	= -L$(LIBFT_DIR)
LINKS	= -lft

### EXECUTABLE ###
NAME		= binary_name
ARGS		= args
VALGRIND	= valgrind --track-origins=yes --leak-check=full

### INCLUDES ###
OBJ_DIR		= bin
SRC_DIR		= src
HEADER		= incl
LIBFT_DIR	= libft
LIBFT		= $(LIBFT_DIR)/libft.a

### SOURCE FILES ###
SRCS	= 	main.c

### HEADER FILES ###
HEADERS	=	$(addprefix $(HEADER)/, binary_name.h)

### OBJECTS ###
OBJS	= $(addprefix $(OBJ_DIR)/, $(SRCS:.c=.o))

### COLORS ###
RESET	= \033[0m
BLACK	= \034[1;30m
RED		= \033[1;31m
GREEN	= \033[1;32m
YELLOW	= \033[1;33m
BLUE	= \033[1;34m
PURPLE	= \033[1;35m
CYAN	= \033[1;36m
WHITE	= \033[1;37m

### RULES ###
all:	$(NAME)

$(LIBFT):
	@echo "$(NAME): $(GREEN)Compiling $(LIBFT_DIR)$(RESET)"
	@make addon -C $(LIBFT_DIR)

$(NAME):	$(LIBFT) $(OBJ_DIR) $(OBJS)
	@$(CC) $(CFLAGS) $(LFLAGS) $(OBJS) $(LINKS) -o $(NAME)
	@echo "$(NAME): $(BLUE)Creating object file -> $(WHITE)$(notdir $@)... $(GREEN)[Done]$(RESET)"
	@echo "$(NAME): $(GREEN)Project successfully compiled$(RESET)"

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.c $(HEADERS)
	@$(CC) $(CFLAGS) -I$(HEADER) -I$(LIBFT_DIR)/$(HEADER) -c $< -o $@
	@echo "$(NAME): $(BLUE)Creating object file -> $(WHITE)$(notdir $@)... $(GREEN)[Done]$(RESET)"

run: $(NAME)
	@./$(NAME) $(ARGS)

val: $(NAME)
	@$(VALGRIND) ./$(NAME) $(ARGS)

clean:
	@make clean -C $(LIBFT_DIR)
	@echo "$(NAME): $(RED)Supressing object files$(RESET)"
	@rm -rf $(OBJ_DIR)

fclean:	clean
	@make fclean -C $(LIBFT_DIR)
	@echo "$(NAME): $(RED)Supressing program file$(RESET)"
	@rm -f $(NAME)

re:	fclean all

.PHONY:	all clean fclean re
