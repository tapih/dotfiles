# /bin/sh
echo "overwrite below?"
echo "  .vimrc          -> ~/.vimrc"
echo "  .ideavimrc      -> ~/.ideavimrc"
echo "  .screenrc       -> ~/.screenrc"
echo "  .zshrc          -> ~/.zshrc"
echo "  .dircolors      -> ~/.dircolors"
echo "  .vim/template   -> ~/.vim/template/'"
while true; do
      echo "[Y/n]"
      read answer
        case $answer in
            '' | [Yy]* )
                cp    $DOTFILES_ROOT/.vimrc ~/.vimrc
                cp    $DOTFILES_ROOT/.zshrc ~/.zshrc
                cp    $DOTFILES_ROOT/.screenrc ~/.screenrc
                cp    $DOTFILES_ROOT/.dircolors ~/.dircolors
                cp    $DOTFILES_ROOT/.tmux.conf ~/.tmux.conf
                cp    $DOTFILES_ROOT/.ideavimrc ~/.ideavimrc
                cp -r $DOTFILES_ROOT/.vim/template ~/.vim/
                source $HOME/.zshrc
                break;
            ;;
            [Nn]* )
                break;
                ;;
            * )
                echo Please answer Y or N.
                ;;
        esac
done
