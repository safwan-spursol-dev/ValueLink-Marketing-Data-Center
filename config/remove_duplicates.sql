-- Remove duplicate Demo Request Form entries
-- Simpler approach: create temp table with IDs to keep, then delete the rest

-- Step 1: Create temp table with IDs to keep (one per unique client/email/date combo)
CREATE TEMPORARY TABLE keep_ids AS
SELECT MIN(id) as keep_id FROM leads 
WHERE form_name = 'Demo Request Form'
GROUP BY client_name, email, created_at;

-- Step 2: Delete from activity_logs that reference duplicate leads
DELETE FROM activity_logs 
WHERE lead_id IN (
  SELECT id FROM leads WHERE form_name = 'Demo Request Form'
) 
AND lead_id NOT IN (SELECT keep_id FROM keep_ids);

-- Step 3: Delete from lead_notes that reference duplicate leads  
DELETE FROM lead_notes 
WHERE lead_id IN (
  SELECT id FROM leads WHERE form_name = 'Demo Request Form'
) 
AND lead_id NOT IN (SELECT keep_id FROM keep_ids);

-- Step 4: Delete duplicate leads
DELETE FROM leads 
WHERE form_name = 'Demo Request Form'
AND id NOT IN (SELECT keep_id FROM keep_ids);

-- Verify results
SELECT 'Duplicate Leads Removed Successfully!' as message;
SELECT COUNT(*) as remaining_demo_leads FROM leads WHERE form_name = 'Demo Request Form';
