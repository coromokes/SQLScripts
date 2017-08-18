CREATE NONCLUSTERED INDEX idx_Orders10 ON [dbo].[Orders] 
(
	[StatusID] ASC,
	[OrderID] ASC,
	[ClientID] ASC,
	[JobTitle] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = on) ON IDX_A
go
CREATE NONCLUSTERED INDEX idx_CandidateSubmissions2 ON [dbo].[CandidateSubmissions] 
(
	[reviewable] ASC,
	[jobOrderID] ASC,
	[externalSubmissionID] ASC,
	[candidateID] ASC,
	[createDateTime] ASC
)
INCLUDE ( [externalCandidateID],
[campaignCode],
[candidateUpdated]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = on) ON IDX_A
go
CREATE NONCLUSTERED INDEX idx_Candidates10 ON [dbo].[Candidates] 
(
	[Active] ASC,
	[CandidateID] ASC,
	[StatusID] ASC,
	[LastName] ASC,
	[FirstName] ASC,
	[MInit] ASC,
	[Email] ASC,
	[City] ASC,
	[State] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = on) ON IDX_A
go
CREATE NONCLUSTERED INDEX idx_CandidateHistory13 ON [dbo].[CandidateHistory] 
(
	[CategoryID] ASC,
	[CreateUserID] ASC,
	[CandidateID] ASC,
	[submissionID] ASC,
	[ID] ASC,
	[ActivityUserID] ASC,
	[HistoryResultID] ASC,
	[ActivityDate] ASC,
	[CreateDate] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = on) ON IDX_A
go
CREATE NONCLUSTERED INDEX idx_CandidateHistory12 ON [dbo].[CandidateHistory] 
(
	[CandidateID] ASC,
	[CreateDate] ASC
)
INCLUDE ( [ID]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = on) ON IDX_A
go
