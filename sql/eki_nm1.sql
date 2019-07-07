-----------------------------------
--最寄駅一覧
-----------------------------------
select
	distinct(eki_nm1)
from
	raw_goto goto
left outer join raw_genba genba on
	goto.pj_no = genba.pj_no;

-----------------------------------
--最寄駅毎の平均販売価格
-----------------------------------
select
	genba.eki_nm1,
	avg(goto.keiyaku_pr)
from
	raw_goto goto
left outer join raw_genba genba on
	goto.pj_no = genba.pj_no
where
	goto.keiyaku_pr <> 99999999999　--testの値を除く
group by
	genba.eki_nm1
order by
	genba.eki_nm1;