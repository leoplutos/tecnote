scriptencoding utf-8
"snippets.vim

augroup lchSnippetsGroup
  autocmd!

  " C语言定义
  autocmd Filetype c inoremap <buffer> ^in #include <><LEFT>
  autocmd Filetype c inoremap <buffer> ^if if () {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^ie if () {<CR>} else {<CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^ii if() {<CR>} else if () {<CR>} else {<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^sw switch () {<CR>case:<CR>break;<CR>default:<CR>break;<CR>}<CR><UP><UP><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^wh while () {<CR><CR>break;<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^fo int i;<CR>for (i = 0; i <= ; i++) {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^st struct  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^en enum  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^fu int funname (int argument) {<CR><CR>return 0;<CR>}<CR><UP><UP><UP><TAB>
  autocmd Filetype c inoremap <buffer> ^ma #include <stdio.h><CR>int main (int argc, char *argv[]) {<CR><CR>return 0;<CR>}<CR><UP><UP><UP><TAB>
  autocmd Filetype c inoremap <buffer> ^pr printf("[DEBUG] [%s at line:%d] - :[%s] \n", __func__, __LINE__, );<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype c inoremap <buffer> ^pe fprintf(stderr, "[ERROR] [%s at line:%d] - :[%s] \n", __func__, __LINE__, );<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>

  " Java语言定义
  autocmd Filetype java inoremap <buffer> ^if if () {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^ie if () {<CR>} else {<CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^ii if () {<CR>} else if () {<CR>} else {<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^sw switch () {<CR>case:<CR>break;<CR>default:<CR>break;<CR>}<CR><UP><UP><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^wh while () {<CR><CR>break;<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^fo for (int i = 0; i <= ; i++) {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^fe for (String element : ) {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^tr try {<CR><CR>} catch (Exception e) {<CR>e.printStackTrace();<CR>}<CR><UP><UP><UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^tf try {<CR><CR>} catch (Exception e) {<CR>e.printStackTrace();<CR>} finally {<CR>}<CR><UP><UP><UP><UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^li List<String>  = new ArrayList<String>();<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^mp Map<String, String>  = new LinkedHashMap<String, String>();<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^cl public class  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^it public interface  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^fi private String ;<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^fu int funname (int argument) {<CR><CR>return 0;<CR>}<CR><UP><UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^ma public static void main(String[] args) throws Exception {<CR><CR>}<CR><UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^logd protected final Logger log = Logger.getLogger(this.getClass());<CR><UP><C-o>$
  autocmd Filetype java inoremap <buffer> ^logp log.debug("", e);<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^pr System.out.printf("[DEBUG] - :[%s] \n", );<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype java inoremap <buffer> ^pe System.err.printf("[ERROR] - :[%s] \n", );<CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>

  " Python语言定义
  autocmd Filetype python inoremap <buffer> ^#! #!/usr/bin/python3<CR># -*- coding: utf-8 -*-<CR><CR>
  autocmd Filetype python inoremap <buffer> ^fr from  import <CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype python inoremap <buffer> ^im import <CR><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype python inoremap <buffer> ^if if :<CR><CR><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^ie if :<CR><BACKSPACE>else:<CR><CR><UP><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^ii if :<CR><BACKSPACE>elif :<CR><BACKSPACE>else:<CR><UP><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^wh while :<CR><CR>break<CR><UP><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^fo for i in range():<CR><CR><UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^fe for element in :<CR><CR><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^tr try:<CR><CR><BACKSPACE>except:<CR><TAB><BACKSPACE># import traceback<CR>traceback.print_exc()<CR><UP><UP><UP><UP><TAB>
  autocmd Filetype python inoremap <buffer> ^tf try:<CR><CR><BACKSPACE>except:<CR><TAB><BACKSPACE># import traceback<CR>traceback.print_exc()<CR><BACKSPACE>finally:<CR><CR><UP><UP><UP><UP><UP><UP><TAB>
  autocmd Filetype python inoremap <buffer> ^li mylist = [1, 2, ]<CR><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^tu mytuple = ('Apple', 'Orange', '')<CR><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^di mydictionary = {'key1': 'value1', 'key2': ''}<CR><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^cl class (object):<CR>def __init__(self, field):<CR>self.__field = field<CR><CR><BACKSPACE>def function_name(self):<CR><CR><UP><UP><UP><UP><UP><UP><C-o>0<C-o>f(
  autocmd Filetype python inoremap <buffer> ^it import abc<CR>class interface_name(metaclass=abc.ABCMeta):<CR><CR>@abc.abstractmethod<CR>def abc_method(self):<CR>pass<CR><UP><UP><UP><UP><UP><C-o>w<C-o>w
  autocmd Filetype python inoremap <buffer> ^fu def function_name(arguments: int = 0) -> None:<CR><CR><UP><UP><C-o>0<C-o>f(
  autocmd Filetype python inoremap <buffer> ^ma def main():<CR><CR><BACKSPACE>if __name__ == "__main__":<CR>main()<CR><UP><UP><UP><TAB>
  autocmd Filetype python inoremap <buffer> ^logd import logging<CR><CR>logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)s [%(process)s] %(filename)s:%(lineno)d - %(message)s',)<CR>
  autocmd Filetype python inoremap <buffer> ^logp logging.debug(f":{}")<CR><UP><C-o>$<CR><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^pr print(f"[DEBUG] [{__name__}] - :{}")<CR><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^pe print(f"[ERROR] [{__name__}] - :{}", file=sys.stderr)<CR><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

  " Rust语言定义
  autocmd Filetype rust inoremap <buffer> ^if if  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^ie if  {<CR>} else {<CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^ii if  {<CR>} else if  {<CR>} else {<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^mc match  {<CR>a => 1,<CR>b => {<CR>2<CR>},<CR>_ => 3,<CR>}<CR><UP><UP><UP><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^wh while  {<CR><CR>break;<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^lo loop {<CR><CR>break;<CR>}<CR><UP><UP><UP><TAB><TAB>
  autocmd Filetype rust inoremap <buffer> ^fo for i in 0..5 {<CR><CR>}<CR><UP><UP><TAB><TAB>
  autocmd Filetype rust inoremap <buffer> ^fe for item in &mut collection {<CR><CR>}<CR><UP><UP><TAB><TAB>
  autocmd Filetype rust inoremap <buffer> ^st struct  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^en enum  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^it pub trait InterfaceName {<CR>fn abc_method(&self) -> String;<CR>}<CR><UP><UP><UP><C-o>w<C-o>w<C-o>w<LEFT>
  autocmd Filetype rust inoremap <buffer> ^tu let mytuple: (i32, f64, u8) = (500, 6.4, 1);<CR><UP><C-o>$
  autocmd Filetype rust inoremap <buffer> ^ve let mut myvec = Vec::new();<CR>myvec.push(1);<CR><UP><C-o>$
  autocmd Filetype rust inoremap <buffer> ^mp let mut mymap = HashMap::new();<CR>mymap.insert("key1", 1);<CR><UP><C-o>$
  autocmd Filetype rust inoremap <buffer> ^fu fn function_name(args: i32) -> i32 {<CR><CR>return 0;<CR>}<CR><UP><UP><UP><TAB>
  autocmd Filetype rust inoremap <buffer> ^ma fn main() {<CR>println!("Hello, world!");<CR>}<UP><C-o>$
  autocmd Filetype rust inoremap <buffer> ^pr println!("[DEBUG] - value:{}", );<CR><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^pe eprintln!("[DEBUG] - value:{}", );<CR><UP><C-o>$<LEFT><LEFT>

  " Go语言定义
  autocmd Filetype go inoremap <buffer> ^if if  {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^ie if  {<CR>} else {<CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^ii if  {<CR>} else if  {<CR>} else {<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^sw switch  {<CR>case 0:<CR>default:<CR>}<CR><UP><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^wh for i < 5 {<CR>}<CR><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^fo for i := 0; i < 100; i++ {<CR>}<CR><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^lo for {<CR><CR>break<CR>}<CR><UP><UP><UP><TAB><TAB>
  autocmd Filetype go inoremap <buffer> ^st type s struct {<CR><CR>}<CR><UP><UP><UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^it type InterfaceName interface {<CR>AbcMethod() int<CR>}<CR><UP><UP><UP><C-o>w<C-o>w<LEFT>
  autocmd Filetype go inoremap <buffer> ^li import "container/list"<CR>mylist := list.New()<CR>mylist.PushBack(1)<CR><UP><C-o>$
  autocmd Filetype go inoremap <buffer> ^mp mymap := make(map[string]int)<CR>mymap["key1"] = 1<CR><UP><C-o>$
  autocmd Filetype go inoremap <buffer> ^fu func function_name(args int) (int) {<CR><CR>return 0<CR>}<CR><UP><UP><UP><TAB>
  autocmd Filetype go inoremap <buffer> ^ma func main() {<CR>fmt.Println("Hello World")<CR>}<UP><C-o>$
  autocmd Filetype go inoremap <buffer> ^pr fmt.Println()<CR><UP><C-o>$<LEFT>
  autocmd Filetype go inoremap <buffer> ^pe fmt.Fprintln(os.Stderr, )<CR><UP><C-o>$<LEFT>

augroup END
