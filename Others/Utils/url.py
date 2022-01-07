import sys
import urllib.parse
import pyperclip

if (str(sys.argv[1])) == '-e':
    encoded_querry = urllib.parse.quote(str(sys.argv[2]))
    print(f"{encoded_querry}\nResult has been copied to the clipboard")
    pyperclip.copy(encoded_querry)
elif (str(sys.argv[1])) == '-d':
    decoded_querry = urllib.parse.unquote(str(sys.argv[2]))
    print(f"{decoded_querry}\nResult has been copied to the clipboard")
    pyperclip.copy(decoded_querry)
