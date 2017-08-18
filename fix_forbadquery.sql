SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SELECT top 100  ch.id, ag.activityGroupName,
				ch.categoryID,
				hcl.description AS category,
				hc.forCallLogs,
				CONVERT(VARCHAR, DATEADD(hh, -2, ch.activityDate), 101) AS activityDate,
				ch.note,
				ISNULL(ch.HistoryResultID, 0) AS resultID,
				hr.Description AS resultDescription,
				ch.Result AS resultText,
				ch.activityUserID,
				ch.createUserID,
				ISNULL(ch.ActivityUserOutlook, 0) AS outlookActivity,
				ISNULL(ch.recurrenceID, 0) AS recurrenceID,
				ch.activityAlarm,
				ch.recurrenceAlarm,
				ch.isTimeSensitive,
				
				ISNULL(ch.candidateID, 0) AS candidateID,
				c.FirstName + ' ' + c.LastName AS candidateName,
					CASE WHEN cmp.phone IS NOT NULL THEN 'c: ' + cmp.phone
						ELSE CASE WHEN chp.phone IS NOT NULL THEN 'h: ' + chp.phone
							ELSE CASE WHEN cwp.phone IS NOT NULL THEN 'w: ' + cwp.phone
								ELSE ''
							END
						END
					END AS candidatePhone,
				
				ISNULL(ch.contactID, 0) AS contactID,
				cc.FirstName + ' ' + cc.LastName AS contactName,
					CASE WHEN ccwp.phone IS NOT NULL THEN 'w: ' + ccwp.phone
						ELSE CASE WHEN cchp.phone IS NOT NULL THEN 'h: ' + cchp.phone
							ELSE CASE WHEN ccmp.phone IS NOT NULL THEN 'c: ' + ccmp.phone
								ELSE ''
							END
						END
					END AS contactPhone,
					
					ISNULL(cb.branchID, 0) AS contactBranchID,
					cb.branchDescription AS contactBranch,
						CASE WHEN cbmp.phone IS NOT NULL THEN 'm: ' + cbmp.phone
							ELSE CASE WHEN cbdp.phone IS NOT NULL THEN 'd: ' + cbdp.phone
								ELSE CASE WHEN cbtf.phone IS NOT NULL THEN 't: ' + cbtf.phone
									ELSE ''
								END
							END
						END AS contactBranchPhone,
					
					ISNULL(cccl.clientID, 0) AS contactClientID,
					cccl.clientName AS contactClient,
						CASE WHEN ccclmp.phone IS NOT NULL THEN 'm: ' + ccclmp.phone
							ELSE CASE WHEN cccldp.phone IS NOT NULL THEN 'd: ' + cccldp.phone
								ELSE CASE WHEN cccltf.phone IS NOT NULL THEN 't: ' + cccltf.phone
									ELSE ''
								END
							END
						END AS contactClientPhone,
				CASE WHEN c.LastName IS NOT NULL THEN c.LastName
					ELSE cc.LastName
				END AS activityLastName,
				CASE WHEN c.firstName IS NOT NULL THEN c.firstName
					ELSE cc.firstName
				END AS activityFirstName,
				
				CASE WHEN cmp.phone IS NOT NULL THEN 'c: ' + cmp.phone
					ELSE CASE WHEN chp.phone IS NOT NULL THEN 'h: ' + chp.phone
						ELSE CASE WHEN cwp.phone IS NOT NULL THEN 'w: ' + cwp.phone
							
							ELSE CASE WHEN ccwp.phone IS NOT NULL THEN 'w: ' + ccwp.phone
								ELSE CASE WHEN cbmp.phone IS NOT NULL THEN 'm: ' + cbmp.phone
									ELSE CASE WHEN ccclmp.phone IS NOT NULL THEN 'm: ' + ccclmp.phone
										ELSE ''
									END
								END
							END
						END
					END
				END AS phone1,
				
				CASE WHEN cmp.phone IS NOT NULL AND chp.phone IS NOT NULL THEN 'h: ' + chp.phone
					ELSE CASE WHEN chp.phone IS NOT NULL AND cwp.phone IS NOT NULL THEN 'w: ' + cwp.phone
						
						ELSE CASE WHEN ccwp.phone IS NOT NULL AND cbmp.phone IS NOT NULL THEN 'm: ' + cbmp.phone
							ELSE CASE WHEN cbmp.phone IS NOT NULL AND ccclmp.phone IS NOT NULL THEN 'm: ' + ccclmp.phone
								ELSE ''
							END
						END
					END
				END AS phone2,
				
				CASE WHEN ISNULL(ch.candidateID, 0) > 0 THEN ch2.activityDate
					ELSE ch3.activityDate
				END AS lastDate,
				
				CASE WHEN ISNULL(ch.candidateID, 0) > 0 THEN ch2.note
					ELSE ch3.note
				END AS lastNote,
				
				CASE WHEN ISNULL(ch.candidateID, 0) > 0 THEN hc2.description
					ELSE hc3.description
				END AS lastCategory
				
			FROM CandidateHistory ch 
			
				LEFT JOIN (SELECT MAX(candidateHistory.id) AS id, candidateHistory.candidateID
			               FROM candidateHistory
						   		INNER JOIN historyCategories ON historyCategories.id = candidateHistory.categoryID
								INNER JOIN historyCategories_lookup ON historyCategories_lookup.hc_id = historyCategories.id
									 AND historyCategories_lookup.perspectiveID = 76
									 AND candidatehistory.ActivityUserID = 8116
						     
						   GROUP BY candidateID) lastActivity on lastActivity.candidateID = ch.candidateID
				INNER JOIN candidateHistory ch2 ON ch2.id = lastActivity.id
				INNER JOIN historyCategories hc2 ON hc2.id = ch2.categoryID
				
				LEFT JOIN (SELECT MAX(candidateHistory.id) AS id, candidateHistory.contactID
			               FROM candidateHistory
						   		INNER JOIN historyCategories ON historyCategories.id = candidateHistory.categoryID
								INNER JOIN historyCategories_lookup ON historyCategories_lookup.hc_id = historyCategories.id
									 AND historyCategories_lookup.perspectiveID = 76
									 AND candidatehistory.ActivityUserID = 8116
						     and isnull(contactid,0) != 0
						   GROUP BY contactID) lastActivity2 on lastActivity2.contactID = ch.contactID
				INNER JOIN candidateHistory ch3 ON ch3.id = lastActivity2.id
				INNER JOIN historyCategories hc3 ON hc3.id = ch3.categoryID
				
				LEFT JOIN activityGroup ag ON ag.activityGroupID = ch.activityGroupID
					
				INNER JOIN historyCategories hc ON hc.id = ch.categoryID
				INNER JOIN historyCategories_lookup hcl ON hcl.hc_id = hc.id
					AND hcl.perspectiveID = 76
				LEFT JOIN HistoryResults hr ON ch.HistoryResultID = hr.ID
				
				LEFT JOIN Candidates c ON c.candidateID = ch.candidateID
					LEFT JOIN CandidatePhones cmp ON cmp.candidateID = c.candidateID AND cmp.typeID = 3
					LEFT JOIN CandidatePhones chp ON chp.candidateID = c.candidateID AND chp.typeID = 2
					LEFT JOIN CandidatePhones cwp ON cwp.candidateID = c.candidateID AND cwp.typeID = 1
				
				LEFT JOIN ClientContacts cc ON cc.contactID = ch.contactID
					LEFT JOIN ContactPhones ccmp ON ccmp.contactID = cc.contactID AND ccmp.typeID = 3
					LEFT JOIN ContactPhones cchp ON cchp.contactID = cc.contactID AND cchp.typeID = 2
					LEFT JOIN ContactPhones ccwp ON ccwp.contactID = cc.contactID AND ccwp.typeID = 1
					LEFT JOIN ClientBranch cb ON cb.branchID = cc.branchID
						LEFT JOIN branchPhones cbmp ON cbmp.branchID = cb.branchID AND cbmp.typeID = 6
						LEFT JOIN branchPhones cbme ON cbme.branchID = cb.branchID AND cbme.typeID = 17
						LEFT JOIN branchPhones cbdp ON cbdp.branchID = cb.branchID AND cbdp.typeID = 10
						LEFT JOIN branchPhones cbtf ON cbtf.branchID = cb.branchID AND cbtf.typeID = 8
					LEFT JOIN Clients cccl ON cccl.clientID = cc.clientID
						LEFT JOIN ClientPhones ccclmp ON ccclmp.clientID = cccl.clientID AND ccclmp.typeID = 6
						LEFT JOIN ClientPhones ccclme ON ccclme.clientID = cccl.clientID AND ccclme.typeID = 17
						LEFT JOIN ClientPhones cccldp ON cccldp.clientID = cccl.clientID AND cccldp.typeID = 10
						LEFT JOIN ClientPhones cccltf ON cccltf.clientID = cccl.clientID AND cccltf.typeID = 8
				
				LEFT JOIN Orders o ON o.orderID = ch.orderID
					LEFT JOIN Clients ocl ON ocl.clientID = o.clientID
						LEFT JOIN ClientPhones oclmp ON oclmp.clientID = ocl.clientID AND oclmp.typeID = 6
						LEFT JOIN ClientPhones oclme ON oclme.clientID = ocl.clientID AND oclme.typeID = 17
						LEFT JOIN ClientPhones ocldp ON ocldp.clientID = ocl.clientID AND ocldp.typeID = 10
						LEFT JOIN ClientPhones ocltf ON ocltf.clientID = ocl.clientID AND ocltf.typeID = 8
			WHERE ch.ActivityUserID = 8116
			AND ch.ActivityDate BETWEEN '1900-01-01'  AND '2020-12-15'
					AND ISNULL(hc.forCallLogs,0) = 1
			--		AND ISNULL(ch.activityGroupID,0) = 60267		
			ORDER BY activityLastName ASC




--select count(*)
--  from candidatehistory
--  where isnull(contactid,0) = 0
  
