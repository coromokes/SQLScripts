/***  Searching for Any Form of a Specific Word (Generation Term) ***/
select *
from srcResume with (nolock)
where contains (ResumeRTF, 'FORMSOF(INFLECTIONAL, "A plus")')

/**** Searching for Multiple Forms of Words or Phrases (Prefix Term) ****/
select count(*) 
	from srcResume with (nolock)
	where contains (ResumeRTF, ' "A+" ' )

/**** Searching for Specific Words or Phrases (Simple Term) ****/
select resumeid
	from srcResume with (nolock)
	where contains (ResumeRTF, '"A+"')


/**** Searching for Words or Phrases Close to Another Word or Phrase (Proximity Term) ***/
select *
	from srcResume with (nolock)
	where contains(ResumeRTF, 'LAN NEAR WAN')
      and resumeid < 1232400

/*** Note   You can use a ~ in place of NEAR ****/


/*** Searching for Words or Phrases Using Weighted Values (Weighted Term) ***/
select *
	from srcResume with (nolock)
	where contains(ResumeRTF, 'ISABOUT ("des*", 
					Plants WEIGHT(0.5), 
	                                Publishers WEIGHT(0.9))')



  



