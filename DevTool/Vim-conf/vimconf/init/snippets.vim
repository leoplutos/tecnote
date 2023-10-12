scriptencoding utf-8
"snippets.vim

augroup lchSnippetsGroup
  autocmd!

  " C语言定义
  autocmd Filetype c inoremap <buffer> ^in #include <><LEFT>
  autocmd Filetype c inoremap <buffer> ^de #define 
  autocmd Filetype c inoremap <buffer> ^id #ifdef <CR><CR>#endif<UP><UP><C-o>$
  autocmd Filetype c inoremap <buffer> ^if if () {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^ie if () {<CR>} else {<CR>}<UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^ii if () {<CR>} else if () {<CR>} else {<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^sw switch () {<CR>case:<CR>break;<CR>default:<CR>break;<CR>}<UP><UP><UP><UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^wh while () {<CR><CR>break;<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^fo int i;<CR>for (i = 0; i < ; i++) {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^st struct  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^en enum  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^fu int function_name (int arguments) {<CR><CR>return 0;<CR>}<UP><UP><TAB>
  autocmd Filetype c inoremap <buffer> ^ma /* #include <stdio.h> */<CR>int main (int argc, char *argv[]) {<CR><CR>return 0;<CR>}<UP><UP><TAB>
  autocmd Filetype c inoremap <buffer> ^pr printf("[DEBUG] [%s at line:%d] - :[%s] \n", __func__, __LINE__, );<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^pe fprintf(stderr, "[ERROR] [%s at line:%d] - :[%s] \n", __func__, __LINE__, );<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype c inoremap <buffer> ^ps printf("[DEBUG] [%s at line:%d] - sqlcode:[%ld] sqlstate:[%s] sqlerrm.sqlerrmc:[%s]\n", __func__, __LINE__, sqlca.sqlcode, sqlca.sqlstate, sqlca.sqlerrm.sqlerrmc);

  " Java语言定义
  autocmd Filetype java inoremap <buffer> ^im import ;<LEFT>
  autocmd Filetype java inoremap <buffer> ^if if () {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^ie if () {<CR>} else {<CR>}<UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^ii if () {<CR>} else if () {<CR>} else {<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^sw switch () {<CR>case:<CR>break;<CR>default:<CR>break;<CR>}<UP><UP><UP><UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^wh while () {<CR><CR>break;<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^wi Iterator<String> it = list.iterator();<CR>while (it.hasNext()) {<CR>String element = it.next();<CR><CR>}<UP><UP><UP><UP><C-o>^<C-o>w<C-o>w<C-o>w
  autocmd Filetype java inoremap <buffer> ^fo for (int i = 0; i < ; i++) {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^fe for (String element : list) {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^tr try {<CR><CR>} catch (Exception e) {<CR>e.printStackTrace();<CR>}<UP><UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^tf try {<CR><CR>} catch (Exception e) {<CR>e.printStackTrace();<CR>} finally {<CR>}<UP><UP><UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^li List<String>  = new ArrayList<String>();<C-o>$<C-o>b<C-o>b<C-o>b<C-o>b<C-o>b<C-o>b<LEFT>
  autocmd Filetype java inoremap <buffer> ^mp Map<String, String>  = new LinkedHashMap<String, String>();<C-o>$<C-o>b<C-o>b<C-o>b<C-o>b<C-o>b<C-o>b<C-o>b<C-o>b<LEFT>
  autocmd Filetype java inoremap <buffer> ^cl public class  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^it public interface  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^fi private String ;<LEFT>
  autocmd Filetype java inoremap <buffer> ^fu int function_name (int arguments) {<CR><CR>return 0;<CR>}<UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^ma public static void main(String[] args) throws Exception {<CR><CR>}<CR><UP><UP><TAB>
  autocmd Filetype java inoremap <buffer> ^logd protected final Logger log = Logger.getLogger(this.getClass());
  autocmd Filetype java inoremap <buffer> ^logp log.debug("", e);<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^pr System.out.printf("[DEBUG] - :[%s] \n", );<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype java inoremap <buffer> ^pe System.err.printf("[ERROR] - :[%s] \n", );<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

  " Python语言定义
  autocmd Filetype python inoremap <buffer> ^he #!/usr/bin/python3<CR># coding=utf-8<CR><CR>
  autocmd Filetype python inoremap <buffer> ^fr from  import <CR><UP><C-o>^<RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype python inoremap <buffer> ^im import <CR><UP><C-o>$
  autocmd Filetype python inoremap <buffer> ^if if :<CR><CR><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^ie if :<CR><BACKSPACE>else:<CR><CR><UP><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^ii if :<CR><BACKSPACE>elif :<CR><BACKSPACE>else:<CR><UP><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^sw match :<CR>case :<CR><BACKSPACE>case _:<CR><UP><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^wh while :<CR><CR><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^fo for i in range():<CR><CR><UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^fe for element in :<CR><CR><UP><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^tr try:<CR><CR><BACKSPACE>except:<CR><TAB><BACKSPACE># import traceback<CR>traceback.print_exc()<CR><UP><UP><UP><UP><TAB>
  autocmd Filetype python inoremap <buffer> ^tf try:<CR><CR><BACKSPACE>except:<CR><TAB><BACKSPACE># import traceback<CR>traceback.print_exc()<CR><BACKSPACE>finally:<CR><CR><UP><UP><UP><UP><UP><UP><TAB>
  autocmd Filetype python inoremap <buffer> ^li mylist = [1, 2, ]<CR><UP><C-o>$<LEFT>
  autocmd Filetype python inoremap <buffer> ^tu mytuple = ('Apple', 'Orange', '')<C-o>$<LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^di mydictionary = {'key1': 'value1', 'key2': ''}<C-o>$<LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^se myset = set(('Apple', 'Orange', ''))<C-o>$<LEFT><LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^cl class (object):<CR>def __init__(self, field: int) -> None:<CR>self.__field = field<CR><CR><BACKSPACE>def function_name(self) -> None:<CR><CR><UP><UP><UP><UP><UP><UP><C-o>0<C-o>f(
  autocmd Filetype python inoremap <buffer> ^it import abc<CR>class interface_name(metaclass=abc.ABCMeta):<CR><CR>@abc.abstractmethod<CR>def function_name(self) -> None:<CR>pass<CR><UP><UP><UP><UP><UP><C-o>w<C-o>w
  autocmd Filetype python inoremap <buffer> ^fu def function_name(arguments: int = 0) -> None:<CR><CR><UP><UP><C-o>0<C-o>f(
  autocmd Filetype python inoremap <buffer> ^ma def main() -> None:<CR><CR><BACKSPACE>if __name__ == "__main__":<CR>main()<CR><UP><UP><UP><TAB>
  autocmd Filetype python inoremap <buffer> ^logd import logging<CR><CR>logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)s [%(process)s] %(filename)s:%(lineno)d - %(message)s',)<CR>
  autocmd Filetype python inoremap <buffer> ^logp logging.debug(f":{}")<CR><UP><C-o>$<CR><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^pr print(f"[DEBUG] [{__name__}] - :{}")<CR><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT>
  autocmd Filetype python inoremap <buffer> ^pe print(f"[ERROR] [{__name__}] - :{}", file=sys.stderr)<CR><UP><C-o>$<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

  " Rust语言定义
  autocmd Filetype rust inoremap <buffer> ^us use ;<LEFT>
  autocmd Filetype rust inoremap <buffer> ^if if  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^ie if  {<CR>} else {<CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^ii if  {<CR>} else if  {<CR>} else {<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^sw match  {<CR>1 => println!("one"),<CR>2 => {<CR>println!("two")<CR>},<CR>_ => (),<CR>}<UP><UP><UP><UP><UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^wh while  {<CR><CR>break;<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^lo loop {<CR><CR>break;<CR>}<UP><UP><TAB><TAB>
  autocmd Filetype rust inoremap <buffer> ^fo for i in 0..5 {<CR><CR>}<CR><UP><UP><TAB><TAB>
  autocmd Filetype rust inoremap <buffer> ^fe for item in &mut list {<CR><CR>}<CR><UP><UP><TAB><TAB>
  autocmd Filetype rust inoremap <buffer> ^st struct  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^en enum  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^sr let  = String::from("");<C-o>^<RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^tu let : (u8, u8) = (500, 321);<C-o>^<RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^ve let mut  = Vec::new();<CR>vec.push(1);<UP><C-o>^<RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^mp let mut  = HashMap::new();<CR>map.insert("1", 2);<UP><C-o>^<RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^fu fn function_name(arguments: i32) -> u32 {<CR><CR>return 0;<CR>}<UP><UP><TAB>
  autocmd Filetype rust inoremap <buffer> ^ma fn main() {<CR>println!("Hello, world!");<CR>}<UP><C-o>$
  autocmd Filetype rust inoremap <buffer> ^it pub trait  {<CR>fn abc_method(&self) -> i32;<CR>}<UP><UP><C-o>^<RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype rust inoremap <buffer> ^pr println!("[DEBUG] - :{}", );<C-o>$<LEFT><LEFT>
  autocmd Filetype rust inoremap <buffer> ^pe eprintln!("[DEBUG] - :{}", );<C-o>$<LEFT><LEFT>

  " Go语言定义
  autocmd Filetype go inoremap <buffer> ^pa package 
  autocmd Filetype go inoremap <buffer> ^im import (<CR>"fmt"<CR>)<UP><C-o>$<CR>
  autocmd Filetype go inoremap <buffer> ^if if  {<CR><CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype go inoremap <buffer> ^ie if  {<CR>} else {<CR>}<UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype go inoremap <buffer> ^ii if  {<CR>} else if  {<CR>} else {<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype go inoremap <buffer> ^sw switch  {<CR>case 0:<CR>default:<CR>}<UP><UP><UP><C-o>$<LEFT><LEFT>
  autocmd Filetype go inoremap <buffer> ^wh for i < 5 {<CR>}<UP><C-o>$<LEFT><LEFT>
  autocmd Filetype go inoremap <buffer> ^lo for {<CR><CR>break<CR>}<UP><UP><TAB><TAB>
  autocmd Filetype go inoremap <buffer> ^fo for i := 0; i < 10; i++ {<CR>}<UP><C-o>$<CR>
  autocmd Filetype go inoremap <buffer> ^fe for i,v:= range list {<CR>}<UP><C-o>$<CR>
  autocmd Filetype go inoremap <buffer> ^st type s struct {<CR><CR>}<UP><UP><C-o>^<RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
  autocmd Filetype go inoremap <buffer> ^li import "container/list"<CR>mylist := list.New()<CR>mylist.PushBack(1)<CR><UP><C-o>$
  autocmd Filetype go inoremap <buffer> ^mp mymap := make(map[string]int)<CR>mymap["key1"] = 1<CR><UP><C-o>$
  autocmd Filetype go inoremap <buffer> ^fu func function_name(args int) (int) {<CR><CR>return 0<CR>}<CR><UP><UP><UP><TAB>
  autocmd Filetype go inoremap <buffer> ^ma func main() {<CR>fmt.Println("Hello World")<CR>}<UP><C-o>$
  autocmd Filetype go inoremap <buffer> ^it type InterfaceName interface {<CR>AbcMethod() int<CR>}<CR><UP><UP><UP><C-o>w<C-o>w<LEFT>
  autocmd Filetype go inoremap <buffer> ^pr fmt.Println("variable:", )<LEFT>
  autocmd Filetype go inoremap <buffer> ^pe fmt.Fprintln(os.Stderr, "variable:", )<LEFT>

augroup END
