## Create a Next.js App
---

### 생성
``` next
npx create-next-app
```

### 실행
```next
npm run dev
```

### 새로운 페이지 생성
 * pages 폴더에 새로운 js 파일을 생성
   * ex) pages/posts/first-post.js
   * http://localhost:3000/posts/first-post
``` next
export default function FirstPost() { ★ 함수이름은 사용자 정의
    return <h1>First Post</h1>
}
```

## Navigate Between Pages
---
### 설명
 * Link 컴포넌트는 Next.js 앱의 페이지 간에  client-side-navigation을 가능하게 함
 * 자바스크립트를 통해서 페이지 전환을 하기 때문에 브라우저 기본 네비게이션보다 빠르다.
 * 페이지 이동시에 refresh가 없다.

### import
``` next
import Link from 'next/link'
```

### 생성
 * a 태그 대신에 Link 태그를 사용한다.
 * a 태그는 Link 태그 안에서 링크를 감싸준다.
``` next
<h1 className="title">
  Read{' '} ★ ' ' 빈칸은 a태그와의 띄어쓰기
  <Link href="/posts/first-post"> 
    <a>this page!</a>
  </Link>
</h1>
```
 * 인덱스 페이지로 가는 링크
``` next
<div className="container">
  <h1>First Post</h1>
  <Link href="/"> ★ index라고 적을 필요 없다.
    <a>Back to home</a>
  </Link>
</div>
```

### Code Splitting and prefetching
 * Next.js는 code splitting을 **자동**으로 수행한다.
 * 그래서 페이지가 render 될 때 필요한 페이지 외에는 초기화 되지 않는다.
 * 각 페이지가 isolated 되어있기 때문에 한 페이지에서 오류가 나도 나머지 애플리케이션은 정상작동한다.
 * Link 태그로 연결된 페이지는 prefetch 되기 때문에 빠르게 이동할 수 있다.
 
### Note
 * 만약 Next.js 앱 외부의 페이지와 연결하고 싶다면 기존의 a 태그를 이동
 * a 태그의 className 속성을 이용하고 싶다면 아래와 같이 사용
``` next
<Link href="/">
  <a className="foo" target="_blank" rel="noopener noreferrer">
    Hello World
  </a>
</Link>
```

## Assets, Metadata, and CSS
---

### 설명
 * Next.js 는 built-in CSS를 제공

### Assets
 * Next.js는 public 폴더 아래로 이미지 같은 정적 요소를 제어.
 * public 폴더 아래의 파일들은 애플리케이션에서 참조된다.
 
#### Image

##### 설명
 * Next.js의 Image 태그는 최신 웹용으로 확장된 next/imageHTML img요소이다.
 * 브라우저에서 지원하는 경우 JPEG보다 약 30 % 작은 **WebP**와 같은 최신 이미지 형식으로 이미지를 자동으로 제공한다.(필요에 따라 이미지 최적화)
 * 뷰포트를 스크롤하는 동안 특정 임계 값에 도달 한 경우에만 페이지 내부의 이미지를 지연로드한다.
 * 동적으로 사용할 다양한 및 사용자 정의 해상도에 대해 다른 이미지 크기를 지정할 수 있다.
 * 사진의 품질을 75 %로 설정된 낮은 임계 값으로 자동 변경한다(각 호출에 대해 변경 가능)

##### Import
``` next
import Image from 'next/image'
```
##### 사용
``` next
<Image
  src="/images/profile.jpg"
  height={144} width={144} alt="woogie"
/>
```

### Metadata

#### Head
 * 리액트에서는 head 태그 대신에 Head 태그를 사용

##### Import
``` next
import Head from 'next/head'
```

##### 사용
``` next
<Head>
  <title>First Post</title>
</Head>
```

### CSS Styling

#### style jsx

##### style 태그
``` next
<style jsx>{`
  ...
`}</style>
```

#### CSS 파일 생성 및 import
 * 반드시 이름을 파일명.module.css 로 생성

##### layout.module.css
``` next
.container {
    max-width: 36rem;
    padding: 0 1rem;
    margin: 3rem auto 6rem;
}
```

##### layout.js
 * className={styles.container}
   * styles는 module.css 파일을 import할 때 지정한 이름
   * container는 module.css 파일에서 정의한 클래스 명
``` next
import styles from './layout.module.css'

export default function Layout({ children }) {
  return (
    <div className={styles.container}>
      {children}
    </div>
  )
}
```

##### first-post.js
 * Layout 태그 사이의 요소들은 layout.js의 default함수를 거쳐 layout이 입힌 채로 나온다.
``` next
import Layout from '../../components/layout'

export default function FirstPost() {
  return (
  <Layout>
    <Head>
      <title>First Post</title>
    </Head>
    <h1>First Post</h1>
    <Link href="/">
      <a>Back to home</a>
    </Link>
    <Image
      src="/images/profile.jpg"
      height={144} width={144} alt="woogie"
    />
  </Layout>
  )
}
```

#### Global Styles
 * 모든 페이지에 같은 CSS 파일이 로드되기 원한다면 사용
 * index.js와 같은 폴더에 _app.js 생성(이름고정)
   * 만든 후에는 반드시 서버를 내리고 다시 올려야함
     * `npm run dev`

##### _app.js
``` next
import '../styles/global.css'

export default function App({ Component, pageProps }) {
  return <Component {...pageProps} />
}	 
```

##### global.css
``` next
html,
body {
  padding: 0;
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu,
    Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
  line-height: 1.6;
  font-size: 18px;
}

* {
  box-sizing: border-box;
}

a {
  color: #0070f3;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

img {
  max-width: 100%;
  display: block;
}
```

## Pre-rendering and Data Fetching
---

### Pre-rendering
 * Next.js는 브라우저가 로드 되면 모든 페이지를 pre-render한다.
 * 생성된 HTML은 최소한의 필요한 자바스크립트 코드가 포함되어 있어 화면을 빠르게 띄운다.
 * 그 후에 자바스크립트가 작동하면서 fully interactive하게 한다. 
 * 이를 hydration이라고 한다.
 * Next를 사용하지 않은 React 앱이라면 pre-render를 지원하지 않음
 * 각 페이지마다 Static Generation 또는 Server-side Rendering를 선택 가능
  
#### Static Generation
 * build time에 HTML를 생성하고 각각의 request마다 재사용 되는 방식
 * 미리 페이지를 생성해 두기 때문에 사용자마다 페이지를 generate할 필요가 없어진다.
 * 상품 페이지, 블로그 게시물, 도움말 등의 정적인 페이지에 사용하면 좋다.

##### getStaticProps
 * async 함수로 외부 파일 시스템에서 데이터를 가져옴
 * pre-render시에 데이터도 함께 render하게 함
 * 이는 build time시 가장 먼저 실행됨
 * 작동 시기
   * In development (npm run dev or yarn dev), getStaticProps runs on every request.
   * In production, getStaticProps runs at build time. 
 * only be exported from a page. You can’t export it from non-page files.

##### gray-matter
 * 파일의 메타데이터(ex. title, date 등)를 YAML Front Matter라고 부른다.
 * 이를 parsing 하기 위한 라이브러리가 gray-matter
``` next
npm install gray-matter
```

##### path
 * nextjs-blog
   * lib
     * posts.js
   * pages
     * index.js
   * posts
     * pre-rendering.md
	 * ssg-ssr.md

##### posts.js
``` next
import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'

★ process.cwd(): node명령을 호출한 작업디렉터리의 절대경로
★ 파라미터로 받은 경로들을 하나로 합쳐서 문자열 형태로 path를 리턴
const postsDirectory = path.join(process.cwd(), 'posts')

export function getSortedPostsData() {
  ★ /posts 폴더 아래의 파일 이름을 읽어들임
  const fileNames = fs.readdirSync(postsDirectory)
  
  ★ 파일들의 데이터를 읽어들여 특정 데이터를 배열로 저장함(map 함수 참고)
  const allPostsData = fileNames.map(fileName => {
    ★ 확장자 .md를 없앤 이름을 id로 함
    const id = fileName.replace(/\.md$/, '')

    ★ 파일이름을 포함한 전체경로를 변수에 저장
    const fullPath = path.join(postsDirectory, fileName)
	
    ★ 파일의 데이터를 읽어 들여 저장
    const fileContents = fs.readFileSync(fullPath, 'utf8')

    ★ gray-matter를 사용해서 metadata section 부분을 파싱
    const matterResult = matter(fileContents)

    ★ id 값과 gray-matter를 사용해 얻어낸 메타데이터를 합쳐서 반환
    ★ id, title, date
    return {
      id,
      ...matterResult.data
    }
  })
  
  ★ 위에서 얻은 데이터 배열을 최신 순으로 정렬하여 리턴
  return allPostsData.sort((a, b) => {
    if (a.date < b.date) {
      return 1
    } else {
      return -1
    }
  })
}
```

##### index.js
``` next
import Head from 'next/head'
import Layout, { siteTitle } from '../components/layout'
import utilStyles from '../styles/utils.module.css'

★ posts.js로부터 getSortedPostsData() 함수를 불러들임
import { getSortedPostsData } from '../lib/posts'

export async function getStaticProps() {

  ★ getSortedPostsData() 함수를 통해 {id, title, date} 데이터를 리턴받음
  const allPostsData = getSortedPostsData()
  return {
    props: {
      allPostsData
    }
  }
}

export default function Home({ allPostsData }) {
  return (
    <Layout home>
      <Head>
        <title>{siteTitle}</title>
      </Head>
      <section className={utilStyles.headingMd}>
        <p>[Your Self Introduction]</p>
        <p>
          (This is a sample website - you’ll be building a site like this on{' '}
          <a href="https://nextjs.org/learn">our Next.js tutorial</a>.)
        </p>
      </section>

      <section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
        <h2 className={utilStyles.headingLg}>Blog</h2>
        <ul className={utilStyles.list}>
          ★ allPostsData의 id, date, title 값을 뽑아 리스트 출력
		  ★ utilStyles는 CSS
          {allPostsData.map(({ id, date, title }) => (
            <li className={utilStyles.listItem} key={id}>
              {title}
              <br />
              {id}
              <br />
              {date}
            </li>
          ))}
        </ul>
      </section>
    </Layout>
  )
}
```

##### Fetch External API or Query Database
 * 외부 API나 DB를 통한 데이터 fetch 가능
 * 이게 가능한 이유는 getStaticProps는 오직 server-side에서만 작동하기 때문
 * broweser를 위한 JS bundle에도 들어가지 않는다.
 * 이는 브라우저를 통할 것 없이 직접 데이터베이스에 쿼리를 작성해서 전달할 수 있다는 뜻

##### 코드 설명
 * 외부 API
``` next
export async function getSortedPostsData() {
  ★ 파일 시스템 대신에 외부 API
  ★ fetch post data from an external API endpoint
  const res = await fetch('..')
  return res.json()
}
```
 * DB 쿼리이용
``` next
import someDatabaseSDK from 'someDatabaseSDK'

const databaseClient = someDatabaseSDK.createClient(...)

export async function getSortedPostsData() {
  ★ 파일 시스템 대신에 DB
  // fetch post data from a database
  return databaseClient.query('SELECT posts...')
}
```

#### Server-side Rendering
 * 각각의 request마다 generate되는 방식
 * getServerSideProps 사용( <-> getStaticProps)

##### getServerSideProps
 * getServerSideProps는 request time마다 실행됨
 * 파라미터 context는 request의 상세인자를 포함하고 있음
 * request time에 데이터가 fetch되어야 하는 경우에만 사용해야 함
``` next
export async function getServerSideProps(context) {
  return {
    props: {
      // props for your component
    }
  }
}
```

#### Client-side-Rendering
 * 데이터를 pre-render할 필요가 없을 경우 사용

##### 순서
 1. 외부 데이터를 필요로 하지 않는 페이지의 부분들을 먼저 정적으로 generate함
 2. 페이지가 로드되면 클라이언트가 자바스크립트를 사용해 외부데이터를 fetch, 데이터를 덧붙힘
 
##### 사용처
 * 유저페이지 같이 private한 정보를 담는 페이지에서 사용
 * 빈번히 데이터가 업데이트 되어 request할 때마다 가장 최신 데이터를 필요로 할 경우 사용
 
##### SWR
 * Client-side-Rendering 할 때 사용
 * caching, revalidation, focus tracking, refetching on interval 등 제공
 * 자세한 것은 [링크참고](https://swr.vercel.app/)
``` next
import useSWR from 'swr'

function Profile() {
  const { data, error } = useSWR('/api/user', fetch)

  if (error) return <div>failed to load</div>
  if (!data) return <div>loading...</div>
  return <div>hello {data.name}!</div>
}
```

## Dynamic Routes
---

### 기본개념
 * 각 파일에 대한 동적경로를 지원

### 사용 라이브러리

#### Render Markdown
 * 설치
``` next
npm install remark remark-html
```

#### Formatting the Date
 * 설치
``` next
npm install date-fns
```
 * /components/date.js
``` next
import { parseISO, format } from "date-fns";

export default function Date({ dateString }) {
  const date = parseISO(dateString);
  
  ★ format은 변경 가능
  return <time dateTime={dateString}>{format(date, "LLLL d, yyyy")}</time>;
}
```
 * [참고](https://date-fns.org/v2.16.1/docs/format)

### 코드 설명

#### posts.js

``` next
import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'
import remark from 'remark'
import html from 'remark-html'

★ 각 파일의 이름만 id값으로 뽑아 배열로 반환
export function getAllPostIds() {
  const fileNames = fs.readdirSync(postsDirectory)
  
  ★ map()함수: 배열의 특정 값만 뽑아서 리스트로 반환
  return fileNames.map(fileName => {
    return {
      params: {
        id: fileName.replace(/\.md$/, '')
      }
    }
  })
}

★ id, html로 변환된 마크다운, matterResult.data(title, date 포함) 리턴
export async function getPostData(id) {
  const fullPath = path.join(postsDirectory, `${id}.md`)
  const fileContents = fs.readFileSync(fullPath, 'utf8')

  ★ gray-matter를 사용해서 metadata section 부분을 파싱
  const matterResult = matter(fileContents)

  ★ remark를 사용해서 마크다운 언어의 콘텐트를 html로 변환
  const processedContent = await remark()
    .use(html)
    .process(matterResult.content)
  const contentHtml = processedContent.toString()

  // Combine the data with the id and contentHtml
  return {
    id,
    contentHtml,
    ...matterResult.data
  }
}
```

#### [id].js
 * Next.js에서 dynamic routes를 사용하기 위해 파일명을 []로 감싼다.
 * 각 파일(여기서는 md파일)을 render하는 페이지
``` next
import Layout from '../../components/layout'
import { getAllPostIds, getPostData } from '../../lib/posts'
import Head from 'next/head'
import Date from '../../components/date'
import utilStyles from '../../styles/utils.module.css'

export default function Post({ postData }) {
  return (
    <Layout>
      <Head>
        <title>{postData.title}</title>
      </Head>

      <article>
        <h1 className={utilStyles.headingXl}>{postData.title}</h1>
        <div className={utilStyles.lightText}>
          <Date dateString={postData.date} />
        </div>
        <div dangerouslySetInnerHTML={{ __html: postData.contentHtml }} />
      </article>
    </Layout>
  );
}

export async function getStaticPaths() {
  const paths = getAllPostIds();
  return {
    paths,
    fallback: false,
  }
}

★  build time시 가장 먼저 실행됨
export async function getStaticProps({ params }) {

  ★ import한 posts.js의 getPostData()를 호출
  ★ id, html로 변환된 마크다운, matterResult.data(title, date 포함)를 받음
  const postData = await getPostData(params.id);
  return {
    props: {
      postData,
    },
  };
}
```

#### index.js
``` next
<section className={`${utilStyles.headingMd} ${utilStyles.padding1px}`}>
  <h2 className={utilStyles.headingLg}>Blog</h2>
  <ul className={utilStyles.list}>
    {allPostsData.map(({ id, date, title }) => (
      <li className={utilStyles.listItem} key={id}>
        
        ★ posts/[id].js를 호출
        ★ 파일명이 id 값이 되며 dynamic routes가 생성되어 있어 해당 파일의 페이지가 호출되는 방식
        <Link href={`/posts/${id}`}>
          {title}
        </Link>
        <br />
        <small className={utilStyles.lightText}>
          <Date dateString={date} />
        </small>
      </li>
    ))}
  </ul>
</section>
```

## getStaticProps 
---

### 기본개념
 * async 함수인 getStaticProps 함수를 export하면 Next.js는 getStaticProps에 의해 return된 props를 이용해 build 시에 pre-rendering 함
``` next
export async function getStaticProps(context) {
  return {
    props: {}, // props로 page component에 전달될 것입니다.
  }
}
```

### 사용처
 * 사용자 요청에 앞서서 build 시에 페이지를 pre-render에 이용할 수 있는 데이터가 있다면
 * headless CMS로부터 오는 데이터가 있다면
 * cached될 수 있는 데이터가 있다면(사용자 별로 말고)
 * SEO를 위해 pre-rendering 되어야만 하는 페이지라면

### context
 * getStaticProps의 파라미터
 * 아래와 같은 key를 가지는 object
 
 * ##### params
   * getStaticPaths함수와 함께 사용되어짐
   * dynamic route에서 사용하는 값으로 route parameter를 가짐
   * ex) [id].js라는 page라면 params에는 { id: ... }와 같은 형태를 가짐

 * ##### preview
   * preview mode에 있다면 true이고 그렇지 않으면 undefined
   * headless CMS에서 data를 fetch할 때 유용
   * Next.js가 build time이 아닌 runtime 요청 시에 기존에 게시된 콘텐츠 대신 현재 CMS에서 draft된 콘텐츠를 render하길 원할 때 유용

 * ##### previewData 
   * preview mode 시에 preview Data set을 가지고 있음

 * ##### locale 
   * 현재 active locale을 포함

 * ##### locales 
   * 모든 supported locales를 포함

 * ##### defaultLocale
   * 설정된 default locale을 포함
 
### return
 * getStaticProps는 다음과 같은 object를 return

 * ##### props
   * required(object)
   * page component가 받을 props object입니다. serializable object로 만들어야만함

 * ##### revalidate
   * optional(number)
   * page re-generate가 일어날 수 있는 시간(초 단위)
   * 예를들어 1초로 적용해놓으면 요청이 들어올 때 1초마다 page를 re-generation함
   * 새로운 post가 생성되더라도 재 build, 재 deploy 하는 것 없이 사용될 수 있음

 * ##### notFound
   * optional(boolean)
   * 404 page로 return 하도록 함
   * **getStaticPaths**에서 fallback: false 일 경우에는 필요하지 않음
     * pre-render되는 path들만 return 되기 때문
``` next
export async function getStaticProps(context) {
  const res = await fetch(`https://.../data`)
  const data = await res.json()

  if (!data) {
    return {
      notFound: true,
    }
  }

  return {
    props: {}, 
  }
}
``` 
 * ##### redirect
   * optinal({ desination: string, permanent: boolean})
   * 내부나 외부 resource로 redirect 하게함
``` next
export async function getStaticProps(context) {
  const res = await fetch(`https://...`)
  const data = await res.json()

  if (!data) {
    return {
      redirect: {
        destination: '/',
        permanent: false,
      },
    }
  }

  return {
    props: {},
  }
}
```

### Note
 * build 시에 redirecting은 현재 허용되지 않음
 * build 시에 redirect를 허용하기 위해 next.config.js에 다음과 같이 추가 해야 됨
``` next
module.exports = {
   async redirects() {
     return [
       {
         source: '/about',
         destination: '/',
         permanent: true,
       },
     ]
   },
 }
```
 * getStaticProps에서 top-level scope module을 사용 할 수 있음
 * getStaticProps에서 import된 module은 클라이언트 측에 번들로 제공되지 않음
   * getStaticProps에서 직접 서버 측 코드를 작성할 수 있음
   * 여기에는 파일 시스템이나 데이터베이스에서 읽는 것이 포함
 * top-level scope module
``` next
import { something } from "<module>"; <-- Global / Top-level scope
```
 * getStaticProps에서 Application내에 API route를 호출하기 위해 fetch()를 사용해서는 안됨
 * 대신 API route 내에서 사용되는 로직(control)을 직접 가져와야 함
 * 이 접근 방식을 위해 코드를 약간 리팩토링해야 할 수도 있음
 * 외부 API에서 가져 오는 것은 괜찮음

## getStaticPaths 
---

### 기본개념
 * dynamic route를 이용한다면, build 시에 HTML을 생성하기 위해 path list를 정의해야할 필요가 있음
 * 이런 경우에 getStaticPaths를 사용
 * Next.js는 getStaticPaths에 정의된 모든 path에 대해 정적으로 pre-rendering을 함
 * server-side에서 build 시에만 동작
 * page에서만 허용
 * 개발 시에는 모든 요청에 대해 동작
```next
export async function getStaticPaths() {
  return {
    paths: [
      { params: { ... } } 
    ],
    fallback: true or false 
  };
}
```

### 사용처
 * dynamic route를 사용한 정적 pre-rendering page가 있다면 사용해야만함
   * getServerSideProps와는 함께 사용할 수 없음

### return
 * ##### paths
   * required
   * pre-render되는 path를 결정
   * ex) pages/posts/[id].js로 dynamic route를 만들었다고 가정
``` next
export async function getStaticPaths() {
  return {
    paths: [
      { params: { id: '1' } },
      { params: { id: '2' } }
    ],
    fallback: ...
  }
}
```
   * Next.js는 posts/1 posts/2를 pages/posts/[id].js를 사용하여 build 시에 정적으로 생성
   * posts/1 posts/2를 pages/posts/[id].js를 사용하여 build 시에 정적으로 생성
   * params는 dynamic route에서 page pathname으로 사용된 parameter와 match되어야만 함
 * ##### fallback
   * required
   * **false**
     * getStaticPaths에 path로 정의되지 않은 것은 404 page로 응답
	 * pre-render하는 path list가 많지 않다면(build시에 모두 정적 생성되기 때문입니다) 사용할 수 있음
	 * 새로운 page가 추가되었을 때는 build를 새로해야 404 page로 가지 않음
   * **true**
     * 매우 많은 수의 정적 페이지들(e-commerce site와 같은? 방대한 데이터에 의존하는)이 있는 app 에서 유용
	 * build 시에 생성 되지 않았던 path들은 404 page가 되지는 않음
	 * 대신 Next.js는 이러한 path들에 대해서 첫 요청이 들어오면 "대체" 버전(fallback 버전)을 제공
	   * background에서는 Next.js가 요청된 path에 대해 정적으로 HTML과 JSON을 생성할 것이고 getStaticProps에 넘겨줌
	   * 사용자 관점에서는 fallback page에서 완전한 page로 swap될 것
	   * 동시에 Next.js는 이 path를 pre-render page 리스트에 추가
	   * 그리고 후속 요청은 정적 생성된 page(build 시 pre-rendering 페이지)와 동일하게 제공
	 * next export 사용시에는 제공되지 않음
	 * Fallback page
	   * next/router를 사용해 fallback 인지 체크
	   * router.isFallback === true
``` next
☆ pages/posts/[id].js

import { useRouter } from 'next/router'

function Post({ post }) {
  const router = useRouter()

  ★ 만약 아직 page가 생성되지 않았다면, 아래와 같이
  ★ Loading...이라는 글자를 보여줍니다.
  ★ (getStaticProps() 동작이 끝나기 전까지)
  if (router.isFallback) {
    return <div>Loading...</div>
  }

  ★ Render post...
}

★ build time 때 호출
export async function getStaticPaths() {
  return {
  
    ★ 정적 생성 : `/posts/1` and `/posts/2`
    paths: [{ params: { id: '1' } }, { params: { id: '2' } }],
    ★ `/posts/3` 와 같은 
    fallback: true,
  }
}

export async function getStaticProps({ params }) {
  const res = await fetch(`https://.../posts/${params.id}`)
  const post = await res.json()

  return {
    props: { post },
    ★ 요청이 들어온다면
    ★ 매 1초당 post를 재 생성 할것입니다.
    revalidate: 1,
  }
}

export default Post
```

## TypeScript
---

### 설치
``` next
npm install --save-dev typescript @types/react @types/node
```

-----------------------------------------------------------

npm i axios

useEffect, useState

npm install semantic-ui-react semantic-ui-css

