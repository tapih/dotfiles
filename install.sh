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
                cp .vimrc ~/.vimrc
                cp .zshrc ~/.zshrc
                cp .screenrc ~/.screenrc
                cp .dircolors ~/.dircolors
                cp .ideavimrc ~/.ideavimrc
                cp -r .vim/template ~/.vim/
                source ~/.zshrc
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
