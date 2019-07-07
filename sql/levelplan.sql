-----------------------------------
--階数・プラン一覧
-----------------------------------
select
	distinct(levelplan)
from
	public.raw_goto;

-----------------------------------
--階数・プラン分割と平均販売価格
-----------------------------------
select
	levelplan,
	keiyaku_pr,
	--階数
 case
		when levelplan like '1F%' then 1
		when levelplan like '2F%' then 2
		when levelplan like '3F%' then 3
		when levelplan like '土地売り%' then 0
	end as level,
	--部屋数
 case
		when levelplan like '土地売り%' then 0
		when levelplan like '%/2%' then 2
		when levelplan like '%/3%' then 3
		when levelplan like '%/4%' then 4
		when levelplan like '%/5%' then 5
		else null
	end as room,
	--サービスルーム数
 case
		when levelplan like '%S%' then 1
		when levelplan like '%2S%' then 2
		else null
	end as service_room
from
	public.raw_goto
where
	keiyaku_pr <> 99999999999;

