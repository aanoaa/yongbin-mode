use utf8;
use open ':std', ':encoding(utf8)';
use Test::More;

use_ok('Yongbinize');

is yongbinize('안녕하세요'), '안녕하새요', '안녕하새요';
is yongbinize('헬퍼'),          '핼퍼',          '핼퍼';
is yongbinize('윗배둘레'),    '윗베둘래',    '윗베둘래';

done_testing();
