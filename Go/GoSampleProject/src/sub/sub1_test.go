package sub

import (
	"reflect"
	"testing"
)

// 测试用例1：以字符分割
func TestSub1(t *testing.T) {
	got := Sub1(1111)
	want := Sub1(2222)
	//DeepEqual比较底层数组
	if !reflect.DeepEqual(got, want) {
		//如果got和want不一致说明你写得代码有问题
		t.Errorf("The values of %v is not %v\n", got, want)
	}
}
