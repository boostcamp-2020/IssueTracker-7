//
//  JsonFactory.swift
//  IssueTracker
//
//  Created by a1111 on 2020/11/09.
//

import Foundation

struct JsonFactory {
    
    static func loadJson(endPoint: EndPointable) -> Data? {
        switch endPoint {
        case BackEndAPI.allIssues:
            return """
            [
                {
                    "id": 1,
                    "title": "회원가입 기능 구현",
                    "status": "closed",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-11-08 19:27:40",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [
                        {
                            "id": 1,
                            "name": "frontend",
                            "description": "",
                            "color": "#000000"
                        },
                        {
                            "id": 2,
                            "name": "backend",
                            "description": "",
                            "color": "#cccccc"
                        }
                    ],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 2,
                    "title": "로그인 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [
                        {
                            "id": 1,
                            "name": "frontend",
                            "description": "",
                            "color": "#000000"
                        },
                        {
                            "id": 2,
                            "name": "backend",
                            "description": "",
                            "color": "#cccccc"
                        }
                    ],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 3,
                    "title": "로그아웃 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [
                        {
                            "id": 1,
                            "name": "frontend",
                            "description": "",
                            "color": "#000000"
                        }
                    ],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 4,
                    "title": "깃허브 로그인 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 5,
                    "title": "이슈 생성 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 6,
                    "title": "이슈 조회 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 7,
                    "title": "이슈 생성 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 8,
                    "title": "이슈 필터 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 9,
                    "title": "마일스톤 생성 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 10,
                    "title": "마일스톤 조회 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 11,
                    "title": "레이블 생성 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 12,
                    "title": "레이블 조회 기능 구현",
                    "status": "open",
                    "createdAt": "2020-10-28 00:00:00",
                    "updatedAt": "2020-10-28 00:00:00",
                    "deletedAt": null,
                    "user_id": 5,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": {
                        "id": 5,
                        "user_id": "98778990",
                        "photo_url": null,
                        "type": "github"
                    },
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 13,
                    "title": "새로운이슈 테스",
                    "status": "open",
                    "createdAt": "2020-11-08 16:37:00",
                    "updatedAt": "2020-11-08 16:37:00",
                    "deletedAt": null,
                    "user_id": null,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": null,
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 14,
                    "title": "새로운이슈 테스트",
                    "status": "open",
                    "createdAt": "2020-11-08 16:37:23",
                    "updatedAt": "2020-11-08 16:37:23",
                    "deletedAt": null,
                    "user_id": null,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": null,
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 15,
                    "title": "hello",
                    "status": "open",
                    "createdAt": "2020-11-08 18:09:19",
                    "updatedAt": "2020-11-08 18:09:19",
                    "deletedAt": null,
                    "user_id": null,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": null,
                    "comments": [],
                    "milestone": null
                },
                {
                    "id": 16,
                    "title": "test",
                    "status": "open",
                    "createdAt": "2020-11-08 18:13:16",
                    "updatedAt": "2020-11-08 18:13:16",
                    "deletedAt": null,
                    "user_id": null,
                    "milestone_id": 1,
                    "labels": [],
                    "assignees": [],
                    "author": null,
                    "comments": [],
                    "milestone": {
                        "id": 1,
                        "title": "1주차",
                        "due_date": "2020-11-03"
                    }
                },
                {
                    "id": 17,
                    "title": "test2",
                    "status": "open",
                    "createdAt": "2020-11-08 18:13:46",
                    "updatedAt": "2020-11-08 18:13:46",
                    "deletedAt": null,
                    "user_id": null,
                    "milestone_id": 1,
                    "labels": [],
                    "assignees": [],
                    "author": null,
                    "comments": [],
                    "milestone": {
                        "id": 1,
                        "title": "1주차",
                        "due_date": "2020-11-03"
                    }
                },
                {
                    "id": 18,
                    "title": "test3",
                    "status": "open",
                    "createdAt": "2020-11-08 18:15:07",
                    "updatedAt": "2020-11-08 18:15:07",
                    "deletedAt": null,
                    "user_id": null,
                    "milestone_id": 1,
                    "labels": [],
                    "assignees": [],
                    "author": null,
                    "comments": [],
                    "milestone": {
                        "id": 1,
                        "title": "1주차",
                        "due_date": "2020-11-03"
                    }
                },
                {
                    "id": 19,
                    "title": "test4",
                    "status": "open",
                    "createdAt": "2020-11-08 18:15:25",
                    "updatedAt": "2020-11-08 18:15:25",
                    "deletedAt": null,
                    "user_id": null,
                    "milestone_id": null,
                    "labels": [],
                    "assignees": [],
                    "author": null,
                    "comments": [],
                    "milestone": null
                }
            ]
            """.data(using: .utf8)
        default:
            return nil
        }
    }
}
