const similar = "oO08 iIlL1 g9qCGQ";
const diacritics_etc = "â é ù ï ø ç Ã Ē Æ œ";
const num = 1234567890;
const alphabet_small = "a b c d e f g h i j k l m n o p q r s t u v w x y z";
const alphabet_big = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
const sycol = " ` ~ ! @ # $ % ^ & * ( ) _ + [ ] { } \ | ; : , . < > / ?";
const nerd_font = "  󱄙                  ╭  ╰              󰩠   ";
/*
o0O s5S 9gq z2Z !|l1Iij {([|])} .,;: ``''"" a@#* vVuUwW <>;^°=-~ öÖüÜäÄßµ \/\/ -- == __
これは日本語テストになります。
这里是一段中文测试。下面是连字测试
-<< -< -<- <-- <--- <<- <- -> ->> --> ---> ->- >- >>- =<< =< =<= <== <=== <<= <= => =>> ==> ===>
=>= >= >>= <-> <--> <---> <----> <=> <==> <===> <====> :: ::: __ <~~ </ </> /> ~~> == != /= ~= <>
=== !== !=== =/= =!= <: := *= *+ <* <*> *> <| <|> |> <. <.> .> +* =* =: :> (* *) [| |] {| |}
 ++ +++ \/ /\ |- -| <!-- <!---

---------------中英文2:1----------------
|ab|cd|ef|gh|ij|kl|mn|op|qr|st|uv|wx|yz|
|这|应|该|是|中|英|文|完|美|的|2:|1等距|
|A0|1!|2@|3#|4$|5%|6^|7&|8*|9(|0)|=+|[]|
*/

window.toggleFavorite = (alias) => {
	if (num == 1) {
		console.log(1);
	} else if (num != 2) {
		console.log(2);
	}
	try {
		let favorites = JSON.parse(localStorage.getItem('favorites')) || [];
		if (favorites.indexOf(alias) > -1) {
			favorites = favorites.filter((v) => {
				return v !== alias;
			});
		} else {
			favorites.push(alias);
		}
		localStorage.setItem('favorites', JSON.stringify(Array.from(new Set(favorites))));
	} catch (err) {
		console.error('could not save favorite', err);
	}
	renderSelectList();
	return false;
};
