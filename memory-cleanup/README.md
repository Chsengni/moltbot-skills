# Clawdbot Memory Cleanup Skill

This skill is used to clean up clawdbot memory files, keeping only the session.json and the latest .jsonl files, to save storage space and maintain system tidiness.

## Features

- Automatically scan session directories
- Retain all session.json files (session metadata)
- Keep only the latest .jsonl file per session (conversation history)
- Delete old .jsonl files to save space
- Simple batch script execution
- Display operation logs

## File Structure

```
memory-cleanup/
├── SKILL.md              # Skill documentation
├── clean_sessions.bat    # Batch cleanup script
├── README.md             # This documentation file
└── references/           # Reference materials (optional)
```

## Usage Methods

### 1. Using Batch Script
```batch
# Run in Command Prompt
clean_sessions.bat
```

### 2. Specify Custom Path
```batch
# Edit the SESSIONS_PATH variable in the script to specify custom path
```

## Important Notes

1. **Backup Important Data**: This operation is irreversible, deleted files cannot be recovered
2. **Session Integrity**: Always retain session.json files, these are important session metadata
3. **Latest Conversation History**: Only keep the latest .jsonl file, containing most recent conversations
4. **Permission Requirements**: Ensure you have read and delete permissions for target directories

## Safety Features

- Display list of files to be deleted before actual deletion
- Retain critical files (session.json)
- Only delete old .jsonl files, latest files are preserved
- Provide warning messages to remind users of the impact of operations

## Use Cases

- Regular maintenance of clawdbot session data
- Free up disk space
- Organize old session history
- Maintain system performance