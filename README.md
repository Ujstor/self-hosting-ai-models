To set the equivalent of Linux's `chmod 600` permissions on the `acme.json` file in Windows, ensuring that only the file owner has read and write access, you can use the following commands in the Command Prompt or PowerShell. Make sure you run Command Prompt or PowerShell as an administrator:

1. **Remove Inheritance**:
   ```
   icacls "./acme.json" /inheritance:r
   ```

2. **Remove All Existing Permissions** (except the owner):
   ```
   icacls "./acme.json" /remove "Authenticated Users" /remove "SYSTEM" /remove "Administrators" /remove "Users"
   ```

3. **Grant Full Access to the Owner Only**:
   ```
   icacls "./acme.json" /grant "Administrator:F"
   ```

Replace `"path\to\acme.json"` with the actual file path and `"username"` with the owner's username. The `F` flag grants full access (read and write) to the owner.

After running these commands, only the specified user (the file owner) will have full access to `acme.json`, and all other users will have no access, which is the equivalent of `chmod 600` in Linux.