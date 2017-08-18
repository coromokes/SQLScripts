select ntuserid, dataservices.dbo.fdba_deencrypt(password)
  from cms_user.dbo.cms_user with (nolock)
  where status = 1
