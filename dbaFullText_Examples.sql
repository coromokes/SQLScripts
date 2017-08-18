/***  Searching for Any Form of a Specific Word (Generation Term) ***/
select count(*)
from Candidates
where contains (Summary, 'FORMSOF(INFLECTIONAL, "director")')

/**** Searching for Multiple Forms of Words or Phrases (Prefix Term) ****/
select count(*)
	from Candidates
	where contains (ResumeRTF, ' "DBA*" ' )

/**** Searching for Specific Words or Phrases (Simple Term) ****/
select count(*)
	from Candidates
	where contains (ResumeRTF, 'business')

/**** Searching for Words or Phrases Close to Another Word or Phrase (Proximity Term) ***/
select count(*)
	from Candidates
	where contains(ResumeRTF, 'SQL NEAR SERVER')
/*** Note   You can use a ~ in place of NEAR ****/


/*** Searching for Words or Phrases Using Weighted Values (Weighted Term) ***/
select *
	from Candidates
	where contains(ResumeRTF, 'ISABOUT ("des*", 
					Plants WEIGHT(0.5), 
	                                Publishers WEIGHT(0.9))')



  



