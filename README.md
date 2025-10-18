Collective Memory Contract

Overview

The Collective Memory Contract is a decentralized “time capsule” system built on the Stacks blockchain. It enables community members to upload, store, and retrieve historical or meaningful events that become immutable and publicly verifiable. Each uploaded event—called a time capsule—contains metadata like title, description, content, creator address, timestamp, and block height, ensuring transparent preservation of collective memories.

🚀 Features

Immutable Storage: Once uploaded, time capsules cannot be modified or deleted.

Automatic Timestamping: Captures both the blockchain timestamp and block height at the time of upload.

Unique Capsule IDs: Each capsule is assigned a sequential, auto-incrementing ID.

Read-Only Retrieval: Anyone can read and verify capsules, creators, and timestamps.

Validation Checks: Ensures all uploaded data fields are non-empty.

🧩 Data Structures
time-capsules (map)
Field	Type	Description
capsule-id	uint	Unique identifier for each time capsule
creator	principal	Address of the user who created the capsule
title	(string-ascii 100)	Title of the time capsule
description	(string-ascii 500)	Short description of the content
content	(string-ascii 1000)	Main body or message of the time capsule
timestamp	uint	Blockchain timestamp at creation
block-height	uint	Block height at creation
next-capsule-id (data var)

Keeps track of the next available capsule ID, initialized at u1.

⚙️ Functions
Public Functions
(upload-capsule (title ...) (description ...) (content ...)) → (response uint uint)

Uploads a new time capsule with validated input fields.

Parameters:

title: Title of the capsule

description: Description of the capsule

content: Full text content

Returns: Capsule ID on success

Errors:

ERR_INVALID_INPUT if any field is empty

Read-Only Functions
Function	Description	Returns
(get-capsule (capsule-id uint))	Retrieves full capsule details by ID	Capsule object or none
(get-total-capsules)	Returns total number of uploaded capsules	uint
(capsule-exists? (capsule-id uint))	Checks if a capsule exists	bool
(get-capsule-creator (capsule-id uint))	Returns the creator principal	principal or none
(get-capsule-timestamp (capsule-id uint))	Returns timestamp of creation	uint or none

🧱 Error Codes
Code	Constant	Meaning
u100	ERR_NOT_AUTHORIZED	Reserved for future use
u101	ERR_CAPSULE_NOT_FOUND	Capsule not found in map
u102	ERR_INVALID_INPUT	Empty or invalid input field

🔒 Immutability

Once uploaded, time capsules cannot be modified or deleted, ensuring that historical data remains permanent and tamper-proof—perfect for preserving events, achievements, or community milestones.

📜 License

This project is released under the MIT License.