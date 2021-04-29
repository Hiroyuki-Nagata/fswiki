###############################################################################
#
# <p>カテゴリおよびカテゴリに属するページの一覧を表示します。</p>
# <pre>
# {{category_list}}
# </pre>
# <p>
#   引数を指定するとそのカテゴリに属するページの一覧が表示されます。
# </p>
# <pre>
# {{category_list カテゴリ名}}
# </pre>
#
###############################################################################
package plugin::category::CategoryList;
use strict;
use warnings;
#==============================================================================
# コンストラクタ
#==============================================================================
sub new {
	my $class = shift;
	my $self = {};
	return bless $self,$class;
}

#==============================================================================
# パラグラフメソッド
#==============================================================================
sub paragraph {
	my $self = shift;
	my $wiki = shift;
	my $category = shift;
	my $cgi = $wiki->get_CGI;
	# タイトルを取得しておく
	my $title  = $wiki->get_title();
	$cgi->param("category",$category);
	my $html = $wiki->call_handler("CATEGORY");
	# タイトルとカテゴリを元に戻す
	$wiki->set_title($title);
	$cgi->param("category","");
	return $html;
}

1;
