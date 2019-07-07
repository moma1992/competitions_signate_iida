-----------------------------------
--路線価と販売価格
-----------------------------------
 select
	goto.id,
	genba.rosenka_hb,
	goto.keiyaku_pr
from
	raw_goto goto
left outer join raw_genba genba on
	goto.pj_no = genba.pj_no
	--where 	genba.yoto1 in ('近隣商業地域','商業地域') 

	where goto.keiyaku_pr <> 99999999999
	--group by genba.kaoku_um

	order by goto.id;
